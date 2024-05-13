// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;

import "@std/Script.sol";
import {Addresses} from "../../data/AddressMapping.sol";

import {TestToken} from "@src/lendingpool/tokenization/TestToken.sol";
import {AToken} from "@src/lendingpool/tokenization/AToken.sol";
import {ILendingPool} from "@src/lendingpool/interfaces/ILendingPool.sol";
import {IAaveIncentivesController} from "@src/lendingpool/interfaces/IAaveIncentivesController.sol";

contract DeployScript is Script {
	function run() external {

		uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");

		vm.startBroadcast(deployPrivateKey);

    /**
    * @dev Initializes the aToken
    * @param pool The address of the lending pool where this aToken will be used
    * @param treasury The address of the Aave treasury, receiving the fees on this aToken
    * @param underlyingAsset The address of the underlying asset of this aToken (E.g. WETH for aWETH)
    * @param incentivesController The smart contract managing potential incentives distribution
    * @param aTokenDecimals The decimals of the aToken, same as the underlying asset's
    * @param aTokenName The name of the aToken
    * @param aTokenSymbol The symbol of the aToken
    */

    ILendingPool lendingPool = ILendingPool(Addresses.LendingPoolAddress);
    IAaveIncentivesController incentivesController = IAaveIncentivesController(msg.sender);
    string memory aTokenName = "Test AToken";
    string memory aTokenSymbol = "TAT";
    bytes memory temp = bytes("");
		AToken(Addresses.TestATokenAddress).initialize(
      lendingPool,
      msg.sender,
      Addresses.TestTokenAddress,
      incentivesController,
      10,
      aTokenName,
      aTokenSymbol,
      temp
		);

		vm.stopBroadcast();
	}
}
