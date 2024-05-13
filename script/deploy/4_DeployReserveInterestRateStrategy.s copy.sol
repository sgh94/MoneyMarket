// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;

import "@std/Script.sol";
import {Addresses} from "../data/AddressMapping.sol";
import {DefaultReserveInterestRateStrategy} from "@src/lendingpool/DefaultReserveInterestRateStrategy.sol";
import {ILendingPoolAddressesProvider} from "@src/lendingpool/interfaces/ILendingPoolAddressesProvider.sol";
//import {STORAGE} from "../src/Storage.sol";

contract DeployScript is Script {
  function run() external {

    uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployPrivateKey);

   /** 
    * @dev params for reserveIntrestRateStrategy constructor
    * @param ILendingPoolAddressesProvider provider
    * @param uint256 optimalUtilizationRate
    * @param uint256 baseVariableBorrowRate
    * @param uint256 variableRateSlope1
    * @param uint256 variableRateSlope2
    * @param uint256 stableRateSlope1
    * @param uint256 stableRateSlope2
    **/

    ILendingPoolAddressesProvider lendingPoolAddressesProvider = ILendingPoolAddressesProvider(Addresses.LendingPoolAddressesProviderAddress);

    DefaultReserveInterestRateStrategy nDefaultReserveInterestRateStrategy = new DefaultReserveInterestRateStrategy(
      lendingPoolAddressesProvider,
      65,
      0,
      8,
      100,
      10,
      100
    );

    vm.stopBroadcast();
  }
}
