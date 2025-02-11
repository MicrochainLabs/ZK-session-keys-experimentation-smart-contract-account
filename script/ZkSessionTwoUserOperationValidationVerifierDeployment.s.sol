pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "../src/ZkSessionTwoUserOperationsValidationVerifier.sol";


//Deploy contract: forge script script/ZkSessionTwoUserOperationValidationVerifierDeployment.s.sol ZkSessionTwoUserOperationValidationVerifierDeployment --broadcast --verify --rpc-url polygon 

/*
    ##### polygon
✅  [Success] Hash: 0x07c950733a72e88349bd28dbfbc794ffaea85b481c67912b2bb998babd2960f4
Contract Address: 0xE3E89757208b09d1666457e4c54062596cC2044f
Block: 67795766

 */
contract ZkSessionTwoUserOperationValidationVerifierDeployment is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
       
        ZkSessionTwoUserOperationsValidationVerifier pv = new ZkSessionTwoUserOperationsValidationVerifier();
        
        vm.stopBroadcast();
    }
}

