// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '../libraries/math/SafeMath.sol';
import {DistributionTypes} from '../libraries/types/DistributionTypes.sol';
import {VersionedInitializable} from '../libraries/aave-upgradeability/VersionedInitializable.sol';
import {DistributionManager} from './DistributionManager.sol';
import {IERC20} from '../dependencies/openzeppelin/contracts/IERC20.sol';
import {IScaledBalanceToken} from '../interfaces/IScaledBalanceToken.sol';
import {IAaveIncentivesController} from '../interfaces/IAaveIncentivesController.sol';

/**
 * @title BaseIncentivesController
 * @notice Abstract contract template to build Distributors contracts for ERC20 rewards to protocol participants
 * @author Aave
 **/
contract BaseIncentivesController is
  VersionedInitializable,
  DistributionManager
{
  // event
  event RewardsAccrued(address indexed user, uint256 amount);

  event RewardsClaimed(address indexed user, address indexed to, uint256 amount);

  event RewardsClaimed(
    address indexed user,
    address indexed to,
    address indexed claimer,
    uint256 amount
  );

  event ClaimerSet(address indexed user, address indexed claimer);


  using SafeMath for uint256;

  uint256 public constant REVISION = 1;

  address public immutable REWARD_TOKEN;

  mapping(address => uint256) internal _usersUnclaimedRewards;

  // this mapping allows whitelisted addresses to claim on behalf of others
  // useful for contracts that hold tokens to be rewarded but don't have any native logic to claim Liquidity Mining rewards
  mapping(address => address) internal _authorizedClaimers;

  modifier onlyAuthorizedClaimers(address claimer, address user) {
    require(_authorizedClaimers[user] == claimer, 'CLAIMER_UNAUTHORIZED');
    _;
  }

  constructor(IERC20 rewardToken, address emissionManager)
    DistributionManager(emissionManager) public 
  {
    REWARD_TOKEN = address(rewardToken);
  }
   
  function configureAssets(address[] calldata assets, uint256[] calldata emissionsPerSecond)
    external
    onlyEmissionManager
  {
    require(assets.length == emissionsPerSecond.length, 'INVALID_CONFIGURATION');

    DistributionTypes.AssetConfigInput[] memory assetsConfig =
      new DistributionTypes.AssetConfigInput[](assets.length);

    for (uint256 i = 0; i < assets.length; i++) {
      require(uint104(emissionsPerSecond[i]) == emissionsPerSecond[i], 'Index overflow at emissionsPerSecond');
      assetsConfig[i].underlyingAsset = assets[i];
      assetsConfig[i].emissionPerSecond = uint104(emissionsPerSecond[i]);
      assetsConfig[i].totalStaked = IScaledBalanceToken(assets[i]).scaledTotalSupply();
    }
    _configureAssets(assetsConfig);
  }
   
  function handleAction(
    address user,
    uint256 totalSupply,
    uint256 userBalance
  ) external {
    uint256 accruedRewards = _updateUserAssetInternal(user, msg.sender, userBalance, totalSupply);
    if (accruedRewards != 0) {
      _usersUnclaimedRewards[user] = _usersUnclaimedRewards[user].add(accruedRewards);
      emit RewardsAccrued(user, accruedRewards);
    }
  }
   
  function getRewardsBalance(address[] calldata assets, address user)
    external
    view
    returns (uint256)
  {
    uint256 unclaimedRewards = _usersUnclaimedRewards[user];

    DistributionTypes.UserStakeInput[] memory userState =
      new DistributionTypes.UserStakeInput[](assets.length);
    for (uint256 i = 0; i < assets.length; i++) {
      userState[i].underlyingAsset = assets[i];
      (userState[i].stakedByUser, userState[i].totalStaked) = IScaledBalanceToken(assets[i])
        .getScaledUserBalanceAndSupply(user);
    }
    unclaimedRewards = unclaimedRewards.add(_getUnclaimedRewards(user, userState));
    return unclaimedRewards;
  }

  function claimRewards(
    address[] calldata assets,
    uint256 amount,
    address to
  ) external returns (uint256) {
    require(to != address(0), 'INVALID_TO_ADDRESS');
    return _claimRewards(assets, amount, msg.sender, msg.sender, to);
  }

  function claimRewardsOnBehalf(
    address[] calldata assets,
    uint256 amount,
    address user,
    address to
  ) external onlyAuthorizedClaimers(msg.sender, user) returns (uint256) {
    require(user != address(0), 'INVALID_USER_ADDRESS');
    require(to != address(0), 'INVALID_TO_ADDRESS');
    return _claimRewards(assets, amount, msg.sender, user, to);
  }

  function claimRewardsToSelf(address[] calldata assets, uint256 amount)
    external
    returns (uint256)
  {
    return _claimRewards(assets, amount, msg.sender, msg.sender, msg.sender);
  }

  function setClaimer(address user, address caller) external onlyEmissionManager {
    _authorizedClaimers[user] = caller;
    emit ClaimerSet(user, caller);
  }

  function getClaimer(address user) external view returns (address) {
    return _authorizedClaimers[user];
  }

  function getUserUnclaimedRewards(address _user) external view returns (uint256) {
    return _usersUnclaimedRewards[_user];
  }

  /**
   * @dev returns the revision of the implementation contract
   */
  function getRevision() internal pure override returns (uint256) {
    return REVISION;
  }

  /**
   * @dev Claims reward for an user on behalf, on all the assets of the lending pool, accumulating the pending rewards.
   * @param amount Amount of rewards to claim
   * @param user Address to check and claim rewards
   * @param to Address that will be receiving the rewards
   * @return Rewards claimed
   **/
  function _claimRewards(
    address[] calldata assets,
    uint256 amount,
    address claimer,
    address user,
    address to
  ) internal returns (uint256) {
    if (amount == 0) {
      return 0;
    }
    uint256 unclaimedRewards = _usersUnclaimedRewards[user];

    if (amount > unclaimedRewards) {
      DistributionTypes.UserStakeInput[] memory userState =
        new DistributionTypes.UserStakeInput[](assets.length);
      for (uint256 i = 0; i < assets.length; i++) {
        userState[i].underlyingAsset = assets[i];
        (userState[i].stakedByUser, userState[i].totalStaked) = IScaledBalanceToken(assets[i])
          .getScaledUserBalanceAndSupply(user);
      }

      uint256 accruedRewards = _claimRewards(user, userState);
      if (accruedRewards != 0) {
        unclaimedRewards = unclaimedRewards.add(accruedRewards);
        emit RewardsAccrued(user, accruedRewards);
      }
    }

    if (unclaimedRewards == 0) {
      return 0;
    }

    uint256 amountToClaim = amount > unclaimedRewards ? unclaimedRewards : amount;
    _usersUnclaimedRewards[user] = unclaimedRewards - amountToClaim; // Safe due to the previous line

    _transferRewards(to, amountToClaim);
    emit RewardsClaimed(user, to, claimer, amountToClaim);

    return amountToClaim;
  }

  /**
   * @dev Abstract function to transfer rewards to the desired account
   * @param to Account address to send the rewards
   * @param amount Amount of rewards to transfer
   */
  function _transferRewards(address to, uint256 amount) internal virtual{
    IERC20(REWARD_TOKEN).transfer(to, amount);
  }
}