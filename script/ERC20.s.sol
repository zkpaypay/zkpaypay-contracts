// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {SJPY} from "../src/SJPY.sol";

contract SJPYScript is Script {
    SJPY public sjpy;

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();
        sjpy = new SJPY();
        vm.stopBroadcast();
    }
}
