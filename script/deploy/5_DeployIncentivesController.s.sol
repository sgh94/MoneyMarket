// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;

import "@std/Script.sol";
import {Addresses} from "../AddressMapping.sol";
import {BaseIncentivesController} from "@src/lendingpool/incentives/BaseIncentivesController.sol";
import {IERC20} from "@src/lendingpool/dependencies/openzeppelin/contracts/IERC20.sol";

//import {STORAGE} from "../src/Storage.sol";

contract DeployScript is Script {
  function run() external {

    uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployPrivateKey);

    IERC20 rewardToken = IERC20(Addresses.TestTokenAddress);
    BaseIncentivesController incentivesController = new BaseIncentivesController(rewardToken, msg.sender);

    vm.stopBroadcast();
  }
}
