// SPDX-License-Identifier: GPL-3.0

//Objective:
//Anyone can send Ethers, ERC-20 and ERC-721 tokens
//Only owner can withdraw
//Anyone can check wallet balance

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol"; 

contract SimpleWallet is Ownable {

    ERC20 ERC20_Contract;
    ERC721 ERC721_Contract;


    constructor() Ownable (){
        transferOwnership(msg.sender);
    }

    receive() payable external{}

    function withdraw(uint _amount) external onlyOwner{
        payable(msg.sender).transfer(_amount);
    }

    function getWalletERC20Balance() external view returns (uint){
        return ERC20_Contract.balanceOf(address(this));
    }


    function getWalletBalance() external view returns (uint){
        return address(this).balance;
    }


    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    function SetFungibleTokenAddress(address TokenAdress) onlyOwner public {
        ERC20_Contract =ERC20(TokenAdress);
    }

    function SetNonFungibleTokenAddress(address TokenAdress) onlyOwner public {
        ERC721_Contract =ERC721(TokenAdress);
    }

    function transferERC20(address to, uint256 amount) public onlyOwner returns (bool) {
        return ERC20_Contract.transfer(to, amount);
    }

    function transferERC721(address from, address to, uint256 tokenId, bytes memory data) public onlyOwner {
        ERC721_Contract.safeTransferFrom(from,to, tokenId,data);
    }

    function Checktotalsupply() public view returns (uint256 supply) {
        supply=ERC20_Contract.totalSupply();
    }


}