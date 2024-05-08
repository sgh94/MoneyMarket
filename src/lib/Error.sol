// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;
pragma abicoder v2;

library Error {
    error Halted();
    error Unauthorized();
    error AssetNotSupportedForCrossChainDeposit(uint32 domain, address asset);

    error InsufficientCap();
    error InsufficientFee(uint256 lack);
    error InsufficientLoad();
    error InsufficientResolvedRedeem(uint256 left);
    error InsufficientBalance(uint256 left);

    error InvalidDomain(uint32 domain);
    error InvalidEpoch(string reason);
    error InvalidDepositRequest(string reason);

    error InvalidMsgLength(uint256 expected, uint256 actual);
    error InvalidMsgType(uint8 msgType);
    error InvalidVaultType(uint8 vaultType);
    error InvalidAddress(string typ);
    error InvalidThreshold(string typ);

    error MaxRemoteRouterReached(uint32 max);
    error VaultAlreadyDisconnected(address vault);
    error VaultAlreadyExists(address vault);
    error DeploymentFailed(string reason);
    error EthTransferFailed(uint256 amount, bytes ret);
    error BridgeNotOperational(uint32 domain);
    error ZeroAmount();
}