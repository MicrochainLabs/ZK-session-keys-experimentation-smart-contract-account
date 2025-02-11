pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "../src/ZkSessionOneUserOperationValidationVerifier.sol";


//Deploy contract: forge script script/ZkSessionOneUserOperationValidationVerifierDeployment.s.sol ZkSessionOneUserOperationValidationVerifierDeployment --broadcast --verify --rpc-url polygon 

/*
##### polygon
✅  [Success] Hash: 0x012f4997833e559ce30add4b340c070206e5e9987185b6f6c3fbad925e0fed46
Contract Address: 0x5155B11Cd4e148c502323eEA2232Aa5D84091a7D
Block: 67795719

 */
contract ZkSessionOneUserOperationValidationVerifierDeployment is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
       
        ZkSessionOneUserOperationValidationVerifier pv = new ZkSessionOneUserOperationValidationVerifier();
        
        vm.stopBroadcast();
    }
}

