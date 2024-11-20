pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "../src/Plonk_vk.sol";


//Deploy contract: forge script script/PlonkVkDeployment.s.sol PlonkVkDeployment --broadcast --verify --rpc-url amoy --legacy 

/*
✅ Hash: 0x906c824fdb62aa2375c4a5e736dcbbb67d86902e4224f3a00acec71f80ffbf49
Contract Address: 0xcf0a7c6a150e0eef8c9695966d3c4f71a9e3a8b9
Block: 14580406

 */
contract PlonkVkDeployment is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
       
        UltraVerifier pv = new UltraVerifier();
        
        vm.stopBroadcast();
    }
}

