// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

/**
 * @title Deploy Address library
 * @author sgh
 */
library Addresses {
  
  address constant WalletAddress = address(0x5803CdB747e1552Be21C5FCa63228aA3D2622873);
  address constant BorrowerAddress = address(0x34501EE677d8180522730e78C213Fec1b53Be5F0);
  address constant Borrower2Address = address(0x67Db9a858c35Ea0061A9fECaFC19A6a4b302A227);

  // Lending Pool
  address constant LendingPoolAddressesProviderAddress = address(0xe24F680D86422Ec5Fc2665cf2A325b6aCf0f796F);
  address constant LendingPoolAddress = address(0xf2D484145C489A00f71e72b637DcB3391d87C86F);
  address constant LendingPoolConfiguratorAddress = address(0xe9c138c7315e4Cb2357323e130bf9fa84A2E0DF2);
  address constant LendingPoolCollateralManagerAddress = address(0xf0F5762DC269c3964e554131af5968486FF61B1B);
  address constant ReserveInterestRateStrategyAddress = address(0x95470D671889225e83b9c86B901691f6d6BEa6a2);
  address constant IncentivesControllerAddress = address(0xc7cAEd757dd2aA393F709784F902341Ea2212caB);
  address constant PriceOracleAddress = address(0x6191e94F31f6d6F2faE9F05646d9FA74f710E80E);
  address constant LendingRateOracleAddress = address(0x48aFf0e4f59bFB289d04866c5daB78D696923145);

  // Token
  address constant TestTokenAddress = address(0x08D8f4C96F2b7F855B9BAB5B40D62a2074b97460);
  address constant TestATokenAddress = address(0x26cC75268526E2688CE9F4d8BA6619c074482691);
  address constant StableDebtTokenAddress = address(0xDE40cF00d4D47EaB4BEB7D50f21497E9EeEae9a2);
  address constant VariableDebtTokenAddress = address(0xb08deF886C1CA837C8Aa5f5a63b1753d922dFa4C);

  address constant CollateralTokenAddress = address(0xd600E02cCEA73a09855ea6f92337E4c767677180);
  address constant CollateralATokenAddress = address(0x0EB1F0B16Bf3d23e89ABd50b1c5a5Dd2f5c57f47);
  address constant CollateralStableDebtTokenAddress = address(0x8e81E4C0613b115348C6d7D96E74DdcBE812ce97);
  address constant CollateralVariableDebtTokenAddress = address(0x485084039f6b4C373E6f58B84694676868Bd0D49);

}