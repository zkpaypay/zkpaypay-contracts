// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract SJPY is ERC20 {   

    constructor() ERC20("ScrollJPY", "SJPY") {
        _mint(msg.sender, 100000 ether);
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}