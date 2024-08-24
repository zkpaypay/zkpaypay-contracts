// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ZKpaypay} from "../src/ZKPayPay.sol";
import {SJPY} from "../src/SJPY.sol";

contract ZKpaypayTest is Test {
    SJPY public sjpy;
    ZKpaypay public zkpaypay;

    function setUp() public {
        sjpy = new SJPY();
        zkpaypay = new ZKpaypay(address(sjpy));
    }

    function testStorePrivateKey(uint256 x) public {
        zkpaypay.storePrivateKey(x);                
    }

    function testStorePublicKey(bytes memory x) public {
        sjpy.mint(address(this), 100 ether);
        sjpy.approve(address(zkpaypay), 100 ether);
        zkpaypay.storePublicKey(x, 100 ether);
    }

    function testSettle(bytes memory x, uint256 y) public {
        zkpaypay.settle(x, y);
    }

    function testGetCipher() public {
        bytes memory x = zkpaypay.getCipher("hello", 2);
        console.logBytes(x);

        bool verify = zkpaypay.verifyCipher(x, 2);
        console.logBool(verify);
    }

    function testStore() public {
        sjpy.mint(address(this), 100 ether);
        sjpy.approve(address(zkpaypay), 100 ether);
        zkpaypay.storePublicKey("hello", 100 ether);

        zkpaypay.storePrivateKey(2);

        zkpaypay.settle("hello", 2);
        sjpy.balanceOf(address(this));

    }
}
