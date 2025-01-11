// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@solady/tokens/ERC20.sol";
import {ECDSA} from "@solady/utils/ECDSA.sol";
import {OwnableRoles} from "@solady/auth/OwnableRoles.sol";

contract ERC20Basic is ERC20, OwnableRoles {
    using ECDSA for bytes32;

    // @notice name of token
    string private name_;
    // @notice symbol of token
    string private symbol_;

    // Constructor
    constructor(string memory _name, string memory _symbol, address owner) {
        name_ = _name;
        symbol_ = _symbol;
        _initializeOwner(owner);
    }

    // Functions requested by the ERC20 by Solady
    function name() public view override returns (string memory) {
        return name_;
    }

    function symbol() public view override returns (string memory) {
        return symbol_;
    }

    // Basic mint function
    function mint(address to, uint256 amount) external payable {
        _mint(to, amount);
    }
}
