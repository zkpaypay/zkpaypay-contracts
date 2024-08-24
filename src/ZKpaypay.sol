// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {IZKpaypay} from "./IZKpaypay.sol";

contract ZKPayPay is IZKpaypay {
    IER20 public token;
    mapping(bytes32 => bool) public openedPrivateKey;
    mapping(bytes32 => bool) public openedPublicKey;

    constructor(address _token) {
        token = IER20(_token);
    }

    function setNumber(uint256 x) public override {
        number = x;
    }

    function storePrivateKey(bytes32 key) external {
        openedPrivateKey[key] = false;
    }

    function storePublicKey(bytes32 key) external {
        openedPublicKey[key] = false;
    }

    function getPublicKey(bytes32 key) public view returns (bool) {
        return openedKey[key];
    }

    function settle(bytes32 key) public override {

    }

    


}