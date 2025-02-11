pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "../src/SimpleAccountFactory.sol";
import "../src/IPolicyVerifier.sol";

//Deploy contract: forge script script/SimpleAccountFactoryDeployment.s.sol SimpleAccountFactoryDeployment --broadcast --verify --rpc-url polygon

//V6:0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789;
//V7:0x0000000071727De22E5E9d8BAf0edAc6f37da032;

 /*
##### polygon
✅  [Success] Hash: 0xb1163d77ac83e62360681c83e8ebadb650d47ae444f27c4048199742578e7a1e
Contract Address: 0xCfF4A052fC6722a48b655Fa8e878033E48C05495
Block: 67795833
  */

contract SimpleAccountFactoryDeployment is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address entryPointAddress = 0x0000000071727De22E5E9d8BAf0edAc6f37da032;
        address oneUserOperationVerifier = 0x5155B11Cd4e148c502323eEA2232Aa5D84091a7D;
        address twoUserOperationVerifier = 0xE3E89757208b09d1666457e4c54062596cC2044f;

        SimpleAccountFactory pv = new SimpleAccountFactory(IEntryPoint(entryPointAddress), IOneUserOpPolicyVerifier(oneUserOperationVerifier), ITwoUserOpPolicyVerifier(twoUserOperationVerifier));
        
        vm.stopBroadcast();
    }
}

