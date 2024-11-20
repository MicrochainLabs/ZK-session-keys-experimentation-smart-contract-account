pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "../src/SimpleAccountFactoryWithNoir.sol";
import "../src/IPolicyVerifier.sol";

//Deploy contract: forge script script/SimpleAccountWithNoirFactoryDeployment.s.sol SimpleAccountWithNoirFactoryDeployment --broadcast --verify --rpc-url amoy --legacy

//V6:0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789;
//V7:0x0000000071727De22E5E9d8BAf0edAc6f37da032;

/*
✅ Hash: 0x4d023e7c295251054590a444352b789887409c241da49c7fd4bc9dc3367e1477
Contract Address: 0x85128e9abd8fd946d028e1ab8318a2e08bb3d9fb
Block: 14580453

 */
contract SimpleAccountWithNoirFactoryDeployment is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address entryPointAddress = 0x0000000071727De22E5E9d8BAf0edAc6f37da032;
        address _ultraVerifier = 0xcf0A7C6a150e0eef8c9695966d3c4F71a9e3A8B9;

        SimpleAccountFactory pv = new SimpleAccountFactory(IEntryPoint(entryPointAddress), UltraVerifier(_ultraVerifier));
        
        vm.stopBroadcast();
    }
}

