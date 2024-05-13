// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;

import "@std/Script.sol";
import {Addresses} from "../../AddressMapping.sol";

import {TestToken} from "@src/lendingpool/tokenization/TestToken.sol";
import {AToken} from "@src/lendingpool/tokenization/AToken.sol";
import {StableDebtToken} from "@src/lendingpool/tokenization/StableDebtToken.sol";
import {VariableDebtToken} from "@src/lendingpool/tokenization/VariableDebtToken.sol";

import {ILendingPool} from "@src/lendingpool/interfaces/ILendingPool.sol";
import {IAaveIncentivesController} from "@src/lendingpool/interfaces/IAaveIncentivesController.sol";

contract DeployScript is Script {
	function run() external {

		uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");

		vm.startBroadcast(deployPrivateKey);

		// string memory tokenName = "Test Token";
    // string memory tokenSymbol = "TT";
		// TestToken nTestToken = new TestToken(tokenName, tokenSymbol);
		//    AToken nTestAToken = new AToken();

		string memory stableDebtTokenName = "Test Stable Debt Token";
		string memory stableDebtTokenSymbol = "TSDT";
		// StableDebtToken nStableDebtToken = new StableDebtToken();
		StableDebtToken stableDebtToken = StableDebtToken(Addresses.StableDebtTokenAddress);

		uint8 debtTokenDecimals = 18;
		bytes memory emptyBytes = "";

		/**
   * @dev Initializes the debt token.
   * @param pool The address of the lending pool where this aToken will be used
   * @param underlyingAsset The address of the underlying asset of this aToken (E.g. WETH for aWETH)
   * @param incentivesController The smart contract managing potential incentives distribution
   * @param debtTokenDecimals The decimals of the debtToken, same as the underlying asset's
   * @param debtTokenName The name of the token
   * @param debtTokenSymbol The symbol of the token
   */

		stableDebtToken.initialize(
			ILendingPool(Addresses.LendingPoolAddress), 
			Addresses.TestTokenAddress, 
			IAaveIncentivesController(Addresses.IncentivesControllerAddress), 
			debtTokenDecimals, 
			stableDebtTokenName, 
			stableDebtTokenSymbol, 
			emptyBytes
		);


		string memory variableDebtTokenName = "Test Variable Debt Token";
		string memory variableDebtTokenSymbol = "TVDT";
		// VariableDebtToken nVariableDebtToken = new VariableDebtToken();
		VariableDebtToken variableDebtToken = VariableDebtToken(Addresses.VariableDebtTokenAddress);

		variableDebtToken.initialize(
			ILendingPool(Addresses.LendingPoolAddress), 
			Addresses.TestTokenAddress, 
			IAaveIncentivesController(Addresses.IncentivesControllerAddress), 
			debtTokenDecimals, 
			variableDebtTokenName, 
			variableDebtTokenSymbol, 
			emptyBytes
		);


		vm.stopBroadcast();
	}
}
//0x03d7B3914D4460e157F9373c06ED2B9d02B23132 