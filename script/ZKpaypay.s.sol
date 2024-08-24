// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ZKpaypay} from "../src/ZKpaypay.sol";

contract ZKpaypayScript is Script {
    address tokenAddress = address(0x0);

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        ZKpaypay zkpaypay = new ZKpaypay(address(0x0));
        vm.stopBroadcast();
    }
}
