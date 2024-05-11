// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;

import "@std/Script.sol";
import {TestToken} from "@src/lendingpool/tokenization/TestToken.sol";
import {AToken} from "@src/lendingpool/tokenization/AToken.sol";

contract DeployScript is Script {
	function run() external {

		uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");

		vm.startBroadcast(deployPrivateKey);

		string memory tokenName = "Test Token";
    string memory tokenSymbol = "TT";
		TestToken nTestToken = new TestToken(tokenName, tokenSymbol);

    AToken nTestAToken = new AToken();

		vm.stopBroadcast();
	}
}
//0x03d7B3914D4460e157F9373c06ED2B9d02B23132