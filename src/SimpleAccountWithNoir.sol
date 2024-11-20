// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;

/* solhint-disable avoid-low-level-calls */
/* solhint-disable no-inline-assembly */
/* solhint-disable reason-string */


import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import "account-abstraction/core/BaseAccount.sol";
import "account-abstraction/core/Helpers.sol";
import "account-abstraction/samples/callback/TokenCallbackHandler.sol";
import {UltraVerifier} from "./Plonk_vk.sol";
import "./BytesLib.sol";



contract SimpleAccountWithNoir is BaseAccount, TokenCallbackHandler, UUPSUpgradeable, Initializable {

    using BytesLib for bytes;

    address public owner;

    /*Update: Merlke tree root of all sessions
              only session tree root on-chain
              Trade-offs!!!*/
    struct ZKSession {
        uint256 merkleTreeRoot;
        uint256 expiration;
    }

  struct ZKSessionSignatureAndProof {
        uint256 opProof;
        address sessionAddress;
        bytes signature;
        bytes proof;
    }

    mapping(address => ZKSession) internal userZKSessions;

    uint256 immutable SNARK_SCALAR_FIELD = 21888242871839275222246405745257275088548364400416034343698204186575808495617;

    // execute(address,uint256,bytes)
    bytes4 public constant EXECUTE_SELECTOR = 0xb61d27f6;
    // executeBatch(address[],uint256[],bytes[])
    bytes4 public constant EXECUTE_BATCH_SELECTOR = 0x47e1da2a;

    UltraVerifier private immutable _ultraVerifier;

    IEntryPoint private immutable _entryPoint;

    event SimpleAccountInitialized(IEntryPoint indexed entryPoint, UltraVerifier ultraVerifier, address indexed owner);
    event newZKSession(address addr, uint256 sessionTreeRoot, uint256 expiration);

    modifier onlyOwner() {
        _onlyOwner();
        _;
    }

    /// @inheritdoc BaseAccount
    function entryPoint() public view virtual override returns (IEntryPoint) {
        return _entryPoint;
    }

    // solhint-disable-next-line no-empty-blocks
    receive() external payable {}

    constructor(IEntryPoint anEntryPoint, UltraVerifier aUltraVerifier) {
        _entryPoint = anEntryPoint;
        _ultraVerifier = aUltraVerifier;
        _disableInitializers();
    }

    function _onlyOwner() internal view {
        //directly from EOA owner, or through the account itself (which gets redirected through execute())
        require(msg.sender == owner || msg.sender == address(this), "only owner");
    }

    /**
     * execute a transaction (called directly from owner, or by entryPoint)
     * @param dest destination address to call
     * @param value the value to pass in this call
     * @param func the calldata to pass in this call
     */
    function execute(address dest, uint256 value, bytes calldata func) external {
        _requireFromEntryPointOrOwner();
        _call(dest, value, func);
    }

    /**
     * execute a sequence of transactions
     * @dev to reduce gas consumption for trivial case (no value), use a zero-length array to mean zero value
     * @param dest an array of destination addresses
     * @param value an array of values to pass to each call. can be zero-length for no-value calls
     * @param func an array of calldata to pass to each call
     */
    function executeBatch(address[] calldata dest, uint256[] calldata value, bytes[] calldata func) external {
        _requireFromEntryPointOrOwner();
        require(dest.length == func.length && (value.length == 0 || value.length == func.length), "wrong array lengths");
        if (value.length == 0) {
            for (uint256 i = 0; i < dest.length; i++) {
                _call(dest[i], 0, func[i]);
            }
        } else {
            for (uint256 i = 0; i < dest.length; i++) {
                _call(dest[i], value[i], func[i]);
            }
        }
    }

    /**
     * @dev The _entryPoint member is immutable, to reduce gas consumption.  To upgrade EntryPoint,
     * a new implementation of SimpleAccount must be deployed with the new EntryPoint address, then upgrading
      * the implementation by calling `upgradeTo()`
      * @param anOwner the owner (signer) of this account
     */
    function initialize(address anOwner) public virtual initializer {
        _initialize(anOwner);
    }

    function _initialize(address anOwner) internal virtual {
        owner = anOwner;
        emit SimpleAccountInitialized(_entryPoint, _ultraVerifier, owner);
    }

    // Require the function call went through EntryPoint or owner
    function _requireFromEntryPointOrOwner() internal view {
        require(msg.sender == address(entryPoint()) || msg.sender == owner, "account: not Owner or EntryPoint");
    }

    function addNewZKSessionKey(address _address, uint256 sessionTreeRoot) external returns (bool) {
        _requireFromEntryPointOrOwner();
        //for testing purpose, session expire after one hour 
        //Update: using validUntil and validAfter
        uint256 expiration= block.timestamp + 3600;
        require(userZKSessions[_address].expiration == 0, "Session already exist");
    
        userZKSessions[_address] = ZKSession({merkleTreeRoot: sessionTreeRoot, expiration: expiration});
        emit newZKSession(_address, sessionTreeRoot, expiration);
        return true;
    }


    function disableZKSessionKey(address _address) external returns (bool) {
        _requireFromEntryPointOrOwner();
        require(userZKSessions[_address].expiration != 0, "Session doesn't exist");
        userZKSessions[_address].expiration = 1;
        return true;
    }

    function _validateSignature(PackedUserOperation calldata userOp, bytes32 userOpHash)
    internal override virtual returns (uint256 validationData) {
        //experimentation purpose: call execute and executeBatch via ZK session key
        if(bytes4(userOp.callData[:4]) == EXECUTE_SELECTOR || bytes4(userOp.callData[:4]) == EXECUTE_BATCH_SELECTOR){
            //only via zk session key
            ZKSessionSignatureAndProof memory zKSessionSignatureAndProof = _decodeSignatureProofCalldata(userOp.signature);
            if(userZKSessions[zKSessionSignatureAndProof.sessionAddress].expiration < block.timestamp){
                //Update: validUntil/validAfter(set values in the session Merkle tree, prove their value on the session tree via the circuit as public input, Helpers.sol: function _packValidationData(bool sigFailed,uint48 validUntil,uint48 validAfter))
                //https://github.com/eth-infinitism/account-abstraction/blob/develop/contracts/core/Helpers.sol#L74
                return SIG_VALIDATION_FAILED;
            }
            if(!_verifyProof(userOp.callData, zKSessionSignatureAndProof, uint256(userOpHash))){
                return SIG_VALIDATION_FAILED;
            }
            if (zKSessionSignatureAndProof.sessionAddress != ECDSA.recover(MessageHashUtils.toEthSignedMessageHash(userOpHash), zKSessionSignatureAndProof.signature))
                return SIG_VALIDATION_FAILED;
            return SIG_VALIDATION_SUCCESS;
        }
        bytes32 hash = MessageHashUtils.toEthSignedMessageHash(userOpHash);
        if (owner != ECDSA.recover(hash, userOp.signature))
            return SIG_VALIDATION_FAILED;
        return SIG_VALIDATION_SUCCESS;
    }

    function _verifyProof(bytes calldata userOpCalldata, ZKSessionSignatureAndProof memory zKSessionSignatureAndProof, uint256 opHash) internal returns (bool) {
        opHash %= SNARK_SCALAR_FIELD;
        if(bytes4(userOpCalldata[:4]) == EXECUTE_SELECTOR){
            address dest =  abi.decode(userOpCalldata[4:36],(address));
            uint256 value =  abi.decode(userOpCalldata[36:68],(uint256));
            uint256 length = abi.decode(userOpCalldata[100:132],(uint256));
            uint256 functionSelector;
            uint256 to;
            if(length > 0){
                bytes memory fnSelector = userOpCalldata[132:136];
                functionSelector = uint256(uint32(bytes4(fnSelector)));
                if( bytes4(userOpCalldata[132:136]) == bytes4(0xa9059cbb)){
                    address toAddress =abi.decode(userOpCalldata[136:168],(address));
                    to = uint256(uint160(toAddress));
                    //uint256 amount = abi.decode(userOpCalldata[168:200],(uint256));
                }else{
                    to = 0;
                }
            }else{
                functionSelector = 0;
                to = 0;
            }
            // Construct the input to the circuit.
            bytes32[] memory publicInputs = new bytes32[](9);
            publicInputs[0] = bytes32(uint256(uint160(address(this))));
            publicInputs[1] = bytes32(uint256(uint160(address(zKSessionSignatureAndProof.sessionAddress))));
            publicInputs[2] = bytes32(opHash);
            publicInputs[3] = bytes32(uint256(uint160(address(dest))));
            publicInputs[4] = bytes32(value);
            publicInputs[5] = bytes32(functionSelector);
            publicInputs[6] = bytes32(to);
            publicInputs[7] = bytes32(userZKSessions[zKSessionSignatureAndProof.sessionAddress].merkleTreeRoot);
            publicInputs[8] = bytes32(zKSessionSignatureAndProof.opProof);
            return _ultraVerifier.verify(zKSessionSignatureAndProof.proof, publicInputs);
        }else{
            return false;
        }
    }

    function _decodeSignatureProofCalldata(bytes calldata proof) public pure returns(ZKSessionSignatureAndProof memory decodedProof ) {
        {
            (
                uint256 _opProof,
                address _address,
                bytes memory _signature,
                bytes memory _proof
            ) = abi.decode(proof, (uint256, address, bytes, bytes));
            decodedProof = ZKSessionSignatureAndProof(_opProof, _address, _signature, _proof);
        }
    }

    function _call(address target, uint256 value, bytes memory data) internal {
        (bool success, bytes memory result) = target.call{value: value}(data);
        if (!success) {
            assembly {
                revert(add(result, 32), mload(result))
            }
        }
    }

    /**
     * check current account deposit in the entryPoint
     */
    function getDeposit() public view returns (uint256) {
        return entryPoint().balanceOf(address(this));
    }

    /**
     * deposit more funds for this account in the entryPoint
     */
    function addDeposit() public payable {
        entryPoint().depositTo{value: msg.value}(address(this));
    }

    /**
     * withdraw value from the account's deposit
     * @param withdrawAddress target to send to
     * @param amount to withdraw
     */
    function withdrawDepositTo(address payable withdrawAddress, uint256 amount) public onlyOwner {
        entryPoint().withdrawTo(withdrawAddress, amount);
    }

    function _authorizeUpgrade(address newImplementation) internal view override {
        (newImplementation);
        _onlyOwner();
    }
}
