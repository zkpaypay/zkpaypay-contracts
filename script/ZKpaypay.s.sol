// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {ZKpaypay} from "../src/ZKpaypay.sol";
import {SJPY} from "../src/SJPY.sol";

contract ZKpaypayScript is Script {
    SJPY public sjpy;
    ZKpaypay public zkpaypay;

    function setUp() public {
        sjpy = new SJPY();
    }

    function run() public {
        vm.startBroadcast();
        zkpaypay = new ZKpaypay(address(sjpy));
        vm.stopBroadcast();
    }
}
