// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Basic_coin} from 'test/foundry/Mock/MockERC20.sol';
import {Basic_NFT} from 'test/foundry/Mock/MockERC721.sol';
import { SimpleWallet } from 'contracts/Wallet/Basic_Wallet.sol';

contract test is Test{
    SimpleWallet public simpleWallet;
    Basic_coin public coin_Contract;
    Basic_NFT public NFT_Contract;

    address user1 = payable(address(0x01));
    address user2 = payable(address(0x02));
    address user3 = payable(address(0x03));

    function setUp() public {
        

        vm.startPrank(user1);
        simpleWallet = new SimpleWallet();
        coin_Contract = new Basic_coin(100e18);
        NFT_Contract = new Basic_NFT();
        simpleWallet.SetFungibleTokenAddress(address(coin_Contract));
        simpleWallet.SetNonFungibleTokenAddress(address(NFT_Contract));
        vm.stopPrank();

    }




    function testBasicERC20Transfer() public {
        

        assertEq(simpleWallet.getWalletERC20Balance(), 0);

        vm.prank(user1);
        coin_Contract.transfer(address(simpleWallet),20e18);

        assertEq(coin_Contract.balanceOf(address(simpleWallet)), 20e18);

        vm.prank(user1);
        simpleWallet.transferERC20(user2,5e18);

        assertEq(coin_Contract.balanceOf(address(simpleWallet)), 15e18);
        assertEq(coin_Contract.balanceOf(user2), 5e18);
        assertEq(coin_Contract.balanceOf(user1), 80e18);


        assertEq(simpleWallet.owner(),address(user1));

    }

    function testBasicERC721Transfer() public {

        assertEq(NFT_Contract.balanceOf(user1), 1);        

        vm.prank(user1);
        NFT_Contract.safeTransferFrom(address(user1),address(simpleWallet),0);

        assertEq(NFT_Contract.balanceOf(address(simpleWallet)), 1);
        assertEq(NFT_Contract.balanceOf(user1), 0);

        vm.prank(user1);
        simpleWallet.transferERC721(address(simpleWallet),user2,0,"0x0");

        assertEq(NFT_Contract.balanceOf(address(simpleWallet)), 0);
        assertEq(NFT_Contract.balanceOf(user2), 1);
        assertEq(NFT_Contract.balanceOf(user1), 0);


        assertEq(simpleWallet.owner(),address(user1));

    }


}