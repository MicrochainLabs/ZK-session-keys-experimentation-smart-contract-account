pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "../src/SimpleAccountFactory.sol";
import "../src/IPolicyVerifier.sol";

//Deploy contract: forge script script/SimpleAccountFactoryDeployment.s.sol SimpleAccountFactoryDeployment --broadcast --verify --rpc-url amoy

//V6:0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789;
//V7:0x0000000071727De22E5E9d8BAf0edAc6f37da032;

contract SimpleAccountFactoryDeployment is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address entryPointAddress = 0x0000000071727De22E5E9d8BAf0edAc6f37da032;
        address oneUserOperationVerifier = 0x1fad9002fAB3D200bb1749a779ed5a331A58b2cE;
        address twoUserOperationVerifier = 0x9fEfed4D4abAeC723EaF9A3F851FC2A57543Abc9;

        SimpleAccountFactory pv = new SimpleAccountFactory(IEntryPoint(entryPointAddress), IOneUserOpPolicyVerifier(oneUserOperationVerifier), ITwoUserOpPolicyVerifier(twoUserOperationVerifier));
        
        vm.stopBroadcast();
    }
}

