// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "@std/Script.sol";
import {Addresses} from "../data/AddressMapping.sol";
import {TokenInfo} from "../data/TokenInfo.sol";

import {ILendingPool} from "@src/lendingpool/interfaces/ILendingPool.sol";
import {IAaveIncentivesController} from "@src/lendingpool/interfaces/IAaveIncentivesController.sol";

import {LendingPoolConfigurator} from "@src/lendingpool/LendingPoolConfigurator.sol";
import {ILendingPoolConfigurator} from '@src/lendingpool/interfaces/ILendingPoolConfigurator.sol';
import {BaseIncentivesController} from "@src/lendingpool/incentives/BaseIncentivesController.sol";

import {TestToken} from "@src/lendingpool/tokenization/TestToken.sol";
import {AToken} from "@src/lendingpool/tokenization/AToken.sol";
import {StableDebtToken} from "@src/lendingpool/tokenization/StableDebtToken.sol";
import {VariableDebtToken} from "@src/lendingpool/tokenization/VariableDebtToken.sol";
import {IERC20} from "@src/lendingpool/dependencies/openzeppelin/contracts/IERC20.sol";


//import {STORAGE} from "../src/Storage.sol";

contract DeployScript is Script, ILendingPoolConfigurator {

  function run() external {

    uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployPrivateKey);

		TestToken collateralToken = new TestToken(TokenInfo.CollateralTokenName, TokenInfo.CollateralTokenSymbol);
		AToken aToken = new AToken();

    ILendingPool lendingPool = ILendingPool(Addresses.LendingPoolAddress);
    IAaveIncentivesController incentivesController = IAaveIncentivesController(msg.sender);
		aToken.initialize(
      lendingPool,
      msg.sender,
      address(collateralToken),
      incentivesController,
      TokenInfo.BaseTokenDecimals,
      TokenInfo.ATokenName,
      TokenInfo.ATokenSymbol,
      TokenInfo.EmptyByte
		);

		/**
   * @dev Initializes the debt token.
   * @param pool The address of the lending pool where this aToken will be used
   * @param underlyingAsset The address of the underlying asset of this aToken (E.g. WETH for aWETH)
   * @param incentivesController The smart contract managing potential incentives distribution
   * @param debtTokenDecimals The decimals of the debtToken, same as the underlying asset's
   * @param debtTokenName The name of the token
   * @param debtTokenSymbol The symbol of the token
   */
		StableDebtToken stableDebtToken = new StableDebtToken();

		stableDebtToken.initialize(
			ILendingPool(Addresses.LendingPoolAddress), 
			Addresses.TestTokenAddress, 
			IAaveIncentivesController(Addresses.IncentivesControllerAddress), 
			TokenInfo.BaseTokenDecimals, 
			TokenInfo.StableDebtTokenName, 
			TokenInfo.StableDebtTokenSymbol, 
			TokenInfo.EmptyByte
		);

		VariableDebtToken variableDebtToken = new VariableDebtToken();

		variableDebtToken.initialize(
			ILendingPool(Addresses.LendingPoolAddress), 
			Addresses.TestTokenAddress, 
			IAaveIncentivesController(Addresses.IncentivesControllerAddress), 
			TokenInfo.BaseTokenDecimals, 
			TokenInfo.VariableDebtTokenName, 
			TokenInfo.VariableDebtTokenSymbol, 
			TokenInfo.EmptyByte
		);

    LendingPoolConfigurator lendingPoolConfigurator = LendingPoolConfigurator(Addresses.LendingPoolConfiguratorAddress);

    InitReserveInput[] memory inputs = new InitReserveInput[](1);
    inputs[0] = InitReserveInput({
        aTokenImpl: address(aToken),
        stableDebtTokenImpl: address(stableDebtToken),
        variableDebtTokenImpl: address(variableDebtToken),
        underlyingAssetDecimals: TokenInfo.BaseTokenDecimals,
        interestRateStrategyAddress: Addresses.ReserveInterestRateStrategyAddress,
        underlyingAsset: address(collateralToken),
        treasury: Addresses.WalletAddress,
        incentivesController: Addresses.IncentivesControllerAddress,
        underlyingAssetName: TokenInfo.CollateralTokenName,
        aTokenName: TokenInfo.ATokenName,
        aTokenSymbol: TokenInfo.ATokenSymbol,
        variableDebtTokenName: TokenInfo.VariableDebtTokenName,
        variableDebtTokenSymbol: TokenInfo.VariableDebtTokenSymbol,
        stableDebtTokenName: TokenInfo.StableDebtTokenName,
        stableDebtTokenSymbol: TokenInfo.StableDebtTokenSymbol,
        params: TokenInfo.EmptyByte // Assuming empty bytes for simplicity
    });

    lendingPoolConfigurator.batchInitReserve(inputs);


    vm.stopBroadcast();
  }
}
