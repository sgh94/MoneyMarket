// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.6.12;

import "@std/Script.sol";
import {Addresses} from "../AddressMapping.sol";
import {LendingPoolAddressesProvider} from "@src/lendingpool/configuration/LendingPoolAddressesProvider.sol";
//import {STORAGE} from "../src/Storage.sol";

contract DeployScript is Script {
	function run() external {

		uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");

		vm.startBroadcast(deployPrivateKey);

		LendingPoolAddressesProvider nLendingPoolAddressesProvider = LendingPoolAddressesProvider(Addresses.LendingPoolAddressesProviderAddress);

		//
		// nLendingPoolAddressesProvider.setLendingPoolImpl(Addresses.LendingPoolAddress);
		// nLendingPoolAddressesProvider.setLendingPoolConfiguratorImpl(Addresses.LendingPoolConfiguratorAddress);
		// nLendingPoolAddressesProvider.setLendingPoolCollateralManager(Addresses.LendingPoolCollateralManagerAddress);
		// nLendingPoolAddressesProvider.setPoolAdmin(address(this));
		// nLendingPoolAddressesProvider.setEmergencyAdmin(address(this));
		// nLendingPoolAddressesProvider.setPriceOracle(address(0x2da88497588bf89281816106C7259e31AF45a663));
		
		nLendingPoolAddressesProvider.getMarketId();
		nLendingPoolAddressesProvider.getLendingPool();
		nLendingPoolAddressesProvider.getLendingPoolConfigurator();
		nLendingPoolAddressesProvider.getLendingPoolCollateralManager();
		nLendingPoolAddressesProvider.getPoolAdmin();
		nLendingPoolAddressesProvider.getEmergencyAdmin();
		nLendingPoolAddressesProvider.getPriceOracle();
		nLendingPoolAddressesProvider.getLendingRateOracle();

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