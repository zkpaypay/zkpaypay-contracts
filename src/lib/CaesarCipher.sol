// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library CaesarCipher {
    function getCipher(bytes memory _text, uint256 _privateKey) external pure returns (bytes memory) {
        bytes memory text = _text;
        for (uint i = 0; i < text.length; i++) {
            bytes1 char = text[i];
            if (char >= 0x41 && char <= 0x5A) { // Uppercase A-Z (ASCII 65-90)
                text[i] = bytes1(uint8((uint8(char) - 0x41 + _privateKey) % 26 + 0x41));
            } else if (char >= 0x61 && char <= 0x7A) { // Lowercase a-z (ASCII 97-122)
                text[i] = bytes1(uint8((uint8(char) - 0x61 + _privateKey) % 26 + 0x61));
            }
        }
        return text;
    }

    function verify(bytes memory _publicKey, uint256 _privateKey) external pure returns (bool) {
        bytes memory text = _publicKey;
        for (uint i = 0; i < text.length; i++) {
            bytes1 char = text[i];
            if (char >= 0x41 && char <= 0x5A) { // Uppercase A-Z (ASCII 65-90)
                if (bytes1(uint8((uint8(char) - 0x41 + _privateKey) % 26 + 0x41)) != text[i]) {
                    return false;
                }
            } else if (char >= 0x61 && char <= 0x7A) { // Lowercase a-z (ASCII 97-122)
                if (bytes1(uint8((uint8(char) - 0x61 + _privateKey) % 26 + 0x61)) != text[i]) {
                    return false;
                }
            }
        }
        return true;
    }

    function decryptionCipher(bytes memory _publicKey, uint256 _privateKey) public pure returns (address, uint256) {
        bytes memory text = _publicKey;
        for (uint i = 0; i < text.length; i++) {
            bytes1 char = text[i];
            if (char >= 0x41 && char <= 0x5A) { // Uppercase A-Z (ASCII 65-90)
                text[i] = bytes1(uint8((uint8(char) - 0x41 + 26 - _privateKey) % 26 + 0x41));
            } else if (char >= 0x61 && char <= 0x7A) { // Lowercase a-z (ASCII 97-122)
                text[i] = bytes1(uint8((uint8(char) - 0x61 + 26 - _privateKey) % 26 + 0x61));
            }
        }

        address extractedAddress;
        uint256 extractedUint256;

        assembly {
            // Extract first 20 bytes for address
            extractedAddress := mload(add(text, 20)) // Offset of 20 bytes for address
            
            // Extract next 32 bytes for uint256
            extractedUint256 := mload(add(text, 52)) // Offset of 20 (address) + 32 (uint256) bytes
        }

        return (extractedAddress, extractedUint256);
    }
}
