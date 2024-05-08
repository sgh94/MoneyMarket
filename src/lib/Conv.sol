// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;
pragma abicoder v2;

import "@oz/token/ERC20/ERC20.sol";
import "@oz/utils/Strings.sol";

import "@src/lib/Error.sol";

library Conv {
    function toBytes32(address addr) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(addr)));
    }

    /// @dev This function must be used to only for inbound hyperlane messages.
    ///      It is not safe to use for chains that are using 32-length bytes address.
    function toAddress(bytes32 bz) internal pure returns (address) {
        if (uint256(bz) > type(uint160).max) {
            revert Error.InvalidAddress(Strings.toHexString(uint256(bz)));
        }
        return address(uint160(uint256(bz)));
    }
}