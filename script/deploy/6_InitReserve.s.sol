// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import "@std/Script.sol";
import {IERC20} from "@src/lendingpool/dependencies/openzeppelin/contracts/IERC20.sol";
import {Addresses} from "../data/AddressMapping.sol";
import {TokenInfo} from "../data/TokenInfo.sol";

import {LendingPoolConfigurator} from "@src/lendingpool/LendingPoolConfigurator.sol";
import {ILendingPoolConfigurator} from '@src/lendingpool/interfaces/ILendingPoolConfigurator.sol';
import {BaseIncentivesController} from "@src/lendingpool/incentives/BaseIncentivesController.sol";


//import {STORAGE} from "../src/Storage.sol";

contract DeployScript is Script, ILendingPoolConfigurator {

  function run() external {

    uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployPrivateKey);

    LendingPoolConfigurator lendingPoolConfigurator = LendingPoolConfigurator(Addresses.LendingPoolConfiguratorAddress);

    InitReserveInput[] memory inputs = new InitReserveInput[](1);
    inputs[0] = InitReserveInput({
        aTokenImpl: Addresses.TestATokenAddress ,
        stableDebtTokenImpl: Addresses.StableDebtTokenAddress,
        variableDebtTokenImpl: Addresses.VariableDebtTokenAddress,
        underlyingAssetDecimals: 18,
        interestRateStrategyAddress: Addresses.ReserveInterestRateStrategyAddress,
        underlyingAsset: Addresses.TestTokenAddress,
        treasury: Addresses.WalletAddress,
        incentivesController: Addresses.IncentivesControllerAddress,
        underlyingAssetName: TokenInfo.TestTokenName,
        aTokenName: TokenInfo.ATokenName,
        aTokenSymbol: TokenInfo.ATokenSymbol,
        variableDebtTokenName: TokenInfo.VariableDebtTokenName,
        variableDebtTokenSymbol: TokenInfo.VariableDebtTokenSymbol,
        stableDebtTokenName: TokenInfo.StableDebtTokenName,
        stableDebtTokenSymbol: TokenInfo.StableDebtTokenSymbol,
        params: "" // Assuming empty bytes for simplicityeeeeee
    });

    lendingPoolConfigurator.batchInitReserve(inputs);


    vm.stopBroadcast();
  }
}
