// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Basic_coin} from 'test/foundry/Mock/MockERC20.sol';
import { SimpleWallet } from 'contracts/Wallet/Basic_Wallet.sol';

contract test is Test{
    SimpleWallet public simpleWallet;
    Basic_coin public coin;

    address user1 = payable(address(0x01));
    address user2 = payable(address(0x02));
    address user3 = payable(address(0x03));

    function setUp() public {
        

        vm.startPrank(user1);
        simpleWallet = new SimpleWallet();
        coin = new Basic_coin(100e18);
        simpleWallet.SetFungibleTokenAddress(address(coin));
        vm.stopPrank();

    }




    function testBasicTransfer() public {
        

        assertEq(simpleWallet.getWalletERC20Balance(), 0);

        vm.prank(user1);
        coin.transfer(address(simpleWallet),20e18);

        assertEq(coin.balanceOf(address(simpleWallet)), 20e18);

        vm.prank(user1);
        simpleWallet.transferERC20(user2,5e18);

        assertEq(coin.balanceOf(address(simpleWallet)), 15e18);
        assertEq(coin.balanceOf(user2), 5e18);
        assertEq(coin.balanceOf(user1), 80e18);


        assertEq(simpleWallet.owner(),address(user1));

    }

}