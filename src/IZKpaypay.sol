// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface IZKpaypay {
    function setNumber(uint256 x) public virtual;

    function number() public virtual view returns (uint256);

    function increment() public virtual;
}