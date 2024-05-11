// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

import {ERC20} from '../dependencies/openzeppelin/contracts/ERC20.sol';

/**
 * @title ERC20 token For Test
 * @dev token for lending pool test(mintable)
 * @author Sgh
 */

contract TestToken is ERC20{
  
  event mintTo(address to, uint256 amount);

  constructor(string memory name, string memory symbol) ERC20(name, symbol) public{
  }

  function mint(address _to, uint256 _amount) public{
    _mint(_to, _amount);
    emit mintTo(_to, _amount);
  }

}
