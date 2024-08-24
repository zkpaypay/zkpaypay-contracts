// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface IZKpaypay {
    function storePrivateKey(bytes32 key) external;
    function storePublicKey(bytes32 key) external;
    function settle(bytes32 key) external;
}