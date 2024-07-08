pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "../src/ZkSessionOneUserOperationValidationVerifier.sol";


//Deploy contract: forge script script/ZkSessionOneUserOperationValidationVerifierDeployment.s.sol ZkSessionOneUserOperationValidationVerifierDeployment --broadcast --verify --rpc-url amoy 

contract ZkSessionOneUserOperationValidationVerifierDeployment is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
       
        ZkSessionOneUserOperationValidationVerifier pv = new ZkSessionOneUserOperationValidationVerifier();
        
        vm.stopBroadcast();
    }
}

