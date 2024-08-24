// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library CaesarCipher {
    // Encrypt the given text using Caesar Cipher
    function getCipher(bytes memory _text, uint256 _privateKey) external pure returns (bytes memory) {
        bytes memory text = new bytes(_text.length);

        for (uint i = 0; i < _text.length; i++) {
            bytes1 char = _text[i];
            if (char >= 0x41 && char <= 0x5A) { // Uppercase A-Z (ASCII 65-90)
                text[i] = bytes1(uint8((uint8(char) - 0x41 + _privateKey) % 26 + 0x41));
            } else if (char >= 0x61 && char <= 0x7A) { // Lowercase a-z (ASCII 97-122)
                text[i] = bytes1(uint8((uint8(char) - 0x61 + _privateKey) % 26 + 0x61));
            } else {
                text[i] = char; // Non-alphabetic characters remain unchanged
            }
        }
        return text;
    }

    // Decrypt the given cipher text using Caesar Cipher
    function _decrypt(bytes memory _cipher, uint256 _privateKey) internal pure returns (bytes memory) {
        bytes memory text = new bytes(_cipher.length);
        for (uint i = 0; i < _cipher.length; i++) {
            bytes1 char = _cipher[i];
            if (char >= 0x41 && char <= 0x5A) { // Uppercase A-Z (ASCII 65-90)
                text[i] = bytes1(uint8((uint8(char) - 0x41 + 26 - (_privateKey % 26)) % 26 + 0x41));
            } else if (char >= 0x61 && char <= 0x7A) { // Lowercase a-z (ASCII 97-122)
                text[i] = bytes1(uint8((uint8(char) - 0x61 + 26 - (_privateKey % 26)) % 26 + 0x61));
            } else {
                text[i] = char; // Non-alphabetic characters remain unchanged
            }
        }
        return text;
    }

    // Decrypt the cipher text and extract address and uint256 value
    function decrypt(bytes memory _cipher, uint256 _privateKey) public pure returns (address, uint256) {
        bytes memory text = _decrypt(_cipher, _privateKey);

        require(text.length >= 52, "Decrypted text is too short");

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

    // Verify the decrypted text by checking if it matches the original address
    function verify(bytes memory _cipher, uint256 _privateKey, address _addr) public pure returns (bool) {
        (address extractedAddress, ) = decrypt(_cipher, _privateKey);
        return extractedAddress == _addr;
    }
}
