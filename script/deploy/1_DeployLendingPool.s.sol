// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;

import "@std/Script.sol";
import {Addresses} from "../data/AddressMapping.sol";
import {LendingPool} from "@src/lendingpool/LendingPool.sol";
//import {STORAGE} from "../src/Storage.sol";

contract DeployScript is Script {
  function run() external {

    uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployPrivateKey);

    LendingPool nLendingPoolAddress = new LendingPool();

    vm.stopBroadcast();
  }
}
