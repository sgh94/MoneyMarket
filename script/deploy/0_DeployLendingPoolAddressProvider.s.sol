// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;

import "@std/Script.sol";
import {Addresses} from "../AddressMapping.sol";
import {LendingPoolAddressesProvider} from "@src/lendingpool/configuration/LendingPoolAddressesProvider.sol";
//import {STORAGE} from "../src/Storage.sol";

contract DeployScript is Script {
	function run() external {

		uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");

		vm.startBroadcast(deployPrivateKey);

		string memory _marketId = "First Market";
		LendingPoolAddressesProvider nLendingPoolAddressesProvider = new LendingPoolAddressesProvider(_marketId);

		vm.stopBroadcast();
	}
}
