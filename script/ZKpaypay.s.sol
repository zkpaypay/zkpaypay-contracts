// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {ZKpaypay} from "../src/ZKpaypay.sol";

contract ZKpaypayScript is Script {
    ZKpaypay public zkpaypay;
    address public sjpy = address(0xBa3E23Dd4263ECFaf6e861A0a2c468C2EE2C3186);

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        zkpaypay = new ZKpaypay(address(sjpy));
        vm.stopBroadcast();
    }
}
