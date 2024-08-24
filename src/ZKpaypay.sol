// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {IZKpaypay} from "./interfaces/IZKpaypay.sol";
import {CaesarCipher} from "./lib/CaesarCipher.sol";

contract ZKpaypay is IZKpaypay, Ownable {

    // address public operatorAddress;

    IERC20 public token;

    mapping(bytes32 => bool) public openedPrivateKey;
    mapping(bytes32 => bool) public openedPublicKey;

    struct Transaction {
        bytes32 publicKey;
        bool settled;
    }

    Transaction[] public transactions;

    constructor(
        address _tokenAddress
    ) Ownable(msg.sender) {
        token = IERC20(_tokenAddress);
    }

    function storePrivateKey(bytes32 key) external {
        openedPrivateKey[key] = false;
    }

    function storePublicKey(bytes32 key) external {
        openedPublicKey[key] = false;
    }

    function _openedKey(bytes32 _privateKey, bytes32 _publicKey) internal view returns (bool) {
        return openedPrivateKey[_privateKey] && openedPublicKey[_publicKey];
    }

    function settle(bytes32 _publicKey, uint256 _privateKey) external {

    }
    
    function _settle(uint256 _privateKey) internal {
        for (uint256 i = 0; i < transactions.length; i++) {
            if (CaesarCipher.verify(transactions[i].publicKey, _privateKey)) {
                transactions[i].settled = true;
                break;
            }
        }
        
        (address _to, uint256 _amount) = CaesarCipher.decryptionCipher(_publicKey, _privateKey);

        IERC20(token).transfer(msg.sender, 1);
    }

}