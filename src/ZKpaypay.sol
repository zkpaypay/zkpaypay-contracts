// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {IZKpaypay} from "./interfaces/IZKpaypay.sol";
import {CaesarCipher} from "./lib/CaesarCipher.sol";

contract ZKpaypay is IZKpaypay, Ownable {
    IERC20 public token;

    struct PublicKeyData {
        bytes key;
        bool settled;
    }

    struct PrivateKeyData {
        uint256 key;
        bool settled;
    }

    PublicKeyData[] public publicKeyData;
    PrivateKeyData[] public privateKeyData;

    constructor(
        address _tokenAddress
    ) Ownable(msg.sender) {
        token = IERC20(_tokenAddress);
    }

    function storePrivateKey(uint256 _key) external {
        privateKeyData.push(PrivateKeyData(_key, false));
    }

    function storePublicKey(bytes memory _key) external {
        publicKeyData.push(PublicKeyData(_key, false));
    }
    
    function settle(bytes memory _publicKey, uint256 _privateKey) external {
        for (uint256 i = 0; i < publicKeyData.length; i++) {
            if (CaesarCipher.verify(publicKeyData[i].key, _privateKey)) {
                (address _to, uint256 _amount) = CaesarCipher.decryptionCipher(_publicKey, _privateKey);
                IERC20(token).transfer(_to, _amount);
                publicKeyData[i].settled = true;
                break;
            }
        }        
    }

    function getCipher(bytes memory _text, uint256 _privateKey) external pure returns (bytes memory) {
        return CaesarCipher.getCipher(_text, _privateKey);
    }
}