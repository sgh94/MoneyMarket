// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.6.12;

import "@std/Script.sol";
import {Addresses} from "../data/AddressMapping.sol";
import {LendingPool} from "@src/lendingpool/LendingPool.sol";
import {LendingPoolAddressesProvider} from "@src/lendingpool/configuration/LendingPoolAddressesProvider.sol";
import {TestToken} from "@src/lendingpool/tokenization/TestToken.sol";

contract DeployScript is Script {
	function run() external {

		uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");

		vm.startBroadcast(deployPrivateKey);

    TestToken depositAsset = TestToken(Addresses.TestTokenAddress);
    depositAsset.mint(Addresses.WalletAddress, 100);
    depositAsset.mint(msg.sender, 100);
    depositAsset.approve(Addresses.LendingPoolAddressesProviderAddress, 100);
    depositAsset.approve(Addresses.LendingPoolAddress, 100);

		LendingPool lendingPool = LendingPool(Addresses.LendingPoolAddress);
    lendingPool.deposit(Addresses.TestTokenAddress, 10, Addresses.WalletAddress);

    lendingPool.withdraw(Addresses.TestTokenAddress, 10, Addresses.BorrowerAddress);


		vm.stopBroadcast();
	}
}



//   function getMarketId() external view returns (string memory);
//   function getAddress(bytes32 id) external view returns (address);
//   function getLendingPool() external view returns (address);
//   function getLendingPoolConfigurator() external view returns (address);
//   function getLendingPoolCollateralManager() external view returns (address);
//   function getPoolAdmin() external view returns (address);
//   function getEmergencyAdmin() external view returns (address);
//   function getPriceOracle() external view returns (address);
//   function getLendingRateOracle() external view returns (address);

//   function setLendingPoolImpl(address pool) external;
//   function setLendingPoolConfiguratorImpl(address configurator) external;
//   function setLendingPoolCollateralManager(address manager) external;
//   function setPoolAdmin(address admin) external;
//   function setEmergencyAdmin(address admin) external;
//   function setPriceOracle(address priceOracle) external;
//   function setLendingRateOracle(address lendingRateOracle) external;
//   function setMarketId(string calldata marketId) external;
//   function setAddress(bytes32 id, address newAddress) external;
//   function setAddressAsProxy(bytes32 id, address impl) external;