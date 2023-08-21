// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 

contract Basic_coin is ERC20("Basic_coin","CN")  {

    
    constructor(uint256 mintAmount) {
        _mint(msg.sender,mintAmount);

    }
}