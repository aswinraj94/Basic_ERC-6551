// SPDX-License-Identifier: GPL-3.0

//Objective:
//Anyone can send Ethers, ERC-20 and ERC-721 tokens
//Only owner can withdraw
//Anyone can check wallet balance

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol"; 

contract SimpleWallet is Ownable {

ERC20 ERC20_Contract;



//The one ho calls the contract for the first time is the owner 
constructor() Ownable ()
{

}

//Payable function returns nothing (setter function only takes ethers as an argument and stores ethers inside the smart contract)
//Since we need ethers to store inside of our wallet (smart contract) 
function getEthToWallet() payable external{}
//We could also use
//receive() payable external{}

//Verify Owner or Not
modifier verifyOwner{
    require(msg.sender==owner(),"Only restricted to Wallet Owner");
    _;
}

//Transfer the amount from caller's account to this wallet (smart contract)
function withdraw(uint _amount) external verifyOwner{
payable(msg.sender).transfer(_amount);
}






function getWalletERC20Balance() external view returns (uint){
return ERC20_Contract.balanceOf(address(this));
}

//To know the owner balance
function getWalletBalance() external view returns (uint){
return address(this).balance;
}

function SetFungibleTokenAddress(address TokenAdress) public {
ERC20_Contract =ERC20(TokenAdress);
}

    function transferERC20(address to, uint256 amount) public onlyOwner returns (bool) {

        return ERC20_Contract.transfer(to, amount);
    }


    function Checktotalsupply() public view returns (uint256 supply) {


        supply=ERC20_Contract.totalSupply();


    }

    function Increaseallowance(address to, uint256 amount) public returns (bool) {

        bool ret_val;

        ret_val=ERC20_Contract.approve(to,amount);

        return ret_val;
    }


    function transferERC721(address to, uint256 amount) public onlyOwner returns (bool) {

        return ERC20_Contract.transfer(to, amount);
    }



}