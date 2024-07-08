pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "../src/ZkSessionTwoUserOperationsValidationVerifier.sol";


//Deploy contract: forge script script/ZkSessionTwoUserOperationValidationVerifierDeployment.s.sol ZkSessionTwoUserOperationValidationVerifierDeployment --broadcast --verify --rpc-url amoy 


contract ZkSessionTwoUserOperationValidationVerifierDeployment is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
       
        ZkSessionTwoUserOperationsValidationVerifier pv = new ZkSessionTwoUserOperationsValidationVerifier();
        
        vm.stopBroadcast();
    }
}

