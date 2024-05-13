// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

/**
 * @title Deploy Address library
 * @author sgh
 */
library Addresses {
  
  address constant WalletAddress = address(0x5803CdB747e1552Be21C5FCa63228aA3D2622873);

  // Lending Pool
  address constant LendingPoolAddressesProviderAddress = address(0xe24F680D86422Ec5Fc2665cf2A325b6aCf0f796F);
  address constant LendingPoolAddress = address(0xf2D484145C489A00f71e72b637DcB3391d87C86F);
  address constant LendingPoolConfiguratorAddress = address(0xe9c138c7315e4Cb2357323e130bf9fa84A2E0DF2);
  address constant LendingPoolCollateralManagerAddress = address(0xf0F5762DC269c3964e554131af5968486FF61B1B);
  address constant ReserveInterestRateStrategyAddress = address(0x95470D671889225e83b9c86B901691f6d6BEa6a2);
  address constant IncentivesControllerAddress = address(0xc7cAEd757dd2aA393F709784F902341Ea2212caB);

  // Token
  address constant TestTokenAddress = address(0x08D8f4C96F2b7F855B9BAB5B40D62a2074b97460);
  address constant TestATokenAddress = address(0x26cC75268526E2688CE9F4d8BA6619c074482691);
  address constant StableDebtTokenAddress = address(0xDE40cF00d4D47EaB4BEB7D50f21497E9EeEae9a2);
  address constant VariableDebtTokenAddress = address(0xb08deF886C1CA837C8Aa5f5a63b1753d922dFa4C);

}