// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

/**
 * @title Deploy Address library
 * @author sgh
 */
library Addresses {
  
  // Lending Pool
  address constant LendingPoolAddressesProviderAddress = address(0xe24F680D86422Ec5Fc2665cf2A325b6aCf0f796F);
  address constant LendingPoolAddress = address(0x719082d5d26B877eF7C36A1c3Ffa84ba5bDa8Ea1);
  address constant LendingPoolConfiguratorAddress = address(0x885b3A9D62440165B97fF57833e60973164C82fa);
  address constant LendingPoolCollateralManagerAddress = address(0xf0F5762DC269c3964e554131af5968486FF61B1B);
  address constant ReserveInterestRateStrategyAddress = address(0x95470D671889225e83b9c86B901691f6d6BEa6a2);
  address constant IncentivesControllerAddress = address(0xc7cAEd757dd2aA393F709784F902341Ea2212caB);

  // Token
  address constant TestTokenAddress = address(0x08D8f4C96F2b7F855B9BAB5B40D62a2074b97460);
  address constant TestATokenAddress = address(0x26cC75268526E2688CE9F4d8BA6619c074482691);
  address constant StableDebtTokenAddress = address(0x824A9aD7e82D3BfEDaaE8C65719eF04fbA29750D);
  address constant VariableDebtTokenAddress = address(0xfc8d5E6dF3965F91fC8B11712E937E99d0c60a93);

}