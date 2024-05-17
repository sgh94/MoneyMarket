// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

/**
 * @title Deploy Address library
 * @author sgh
 */
library TokenInfo {

  string constant TestTokenName = "Test Token";
  string constant TestTokenSymbol = "TT";

  string constant CollateralTokenName = "Collateral Token";
  string constant CollateralTokenSymbol = "CT";

  string constant ATokenName = "Test AToken";
  string constant ATokenSymbol = "TAT";

  string constant StableDebtTokenName = "Test Stable Debt Token";
  string constant StableDebtTokenSymbol = "TSDT";

  string constant VariableDebtTokenName = "Test Variable Debt Token";
  string constant VariableDebtTokenSymbol = "TVDT";

  uint8 constant BaseTokenDecimals = 18;
  bytes constant EmptyByte = "";

}