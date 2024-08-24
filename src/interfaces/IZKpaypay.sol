// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface IZKpaypay {
    function storePrivateKey(uint256 _key) external;
    function storePublicKey(bytes memory _key) external;
    function settle(bytes memory _publicKey, uint256 _privateKey) external;
    function getCipher(bytes memory _text, uint256 _privateKey) external pure returns (bytes memory);
}