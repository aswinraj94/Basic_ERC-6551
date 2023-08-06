// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.18;

//import "forge-std/src/Test.sol";
import "forge-std/src/console.sol";


import { SimpleWallet } from 'contracts/Wallet/Basic_Wallt.sol';

contract test{
    SimpleWallet public simpleWallet;

function setUp() public {
    simpleWallet = new SimpleWallet();
}




    function testTransfer() view public {
        simpleWallet.getWalletBalance();
        //assertEq(counter.count(), 1);
    }

}