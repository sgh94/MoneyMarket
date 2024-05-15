// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;

import "@std/Script.sol";
import {Addresses} from "../data/AddressMapping.sol";
import {LendingRateOracle} from "@src/lendingpool/LendingRateOracle.sol";
import {PriceOracle} from "@src/lendingpool/PriceOracle.sol";

import {WadRayMath} from "@src/lendingpool/libraries/math/WadRayMath.sol";

//import {STORAGE} from "../src/Storage.sol";

contract DeployScript is Script {

  function run() external {

    uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployPrivateKey);

    // LendingRateOracle lendingRateOracle = new LendingRateOracle();
    PriceOracle priceOracle = PriceOracle(Addresses.PriceOracleAddress);

    // lendingRateOracle.setMarketBorrowRate(Addresses.TestTokenAddress, WadRayMath.ray()/10);
    // lendingRateOracle.setMarketLiquidityRate(Addresses.TestTokenAddress, WadRayMath.ray()/10);

    priceOracle.setAssetPrice(Addresses.TestTokenAddress, 10**27);
    priceOracle.setAssetPrice(Addresses.CollateralTokenAddress, 10**27);
    
    vm.stopBroadcast();
  }
}
