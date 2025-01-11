// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@solady/tokens/ERC20.sol";
import {ECDSA} from "@solady/utils/ECDSA.sol";
import {OwnableRoles} from "@solady/auth/OwnableRoles.sol";

import {Core} from "@modular-contracts/Core.sol";
import {BeforeMintCallbackERC20} from "./BeforeMintCallbackERC20.sol";

contract ERC20Basic is ERC20, OwnableRoles, Core {
    using ECDSA for bytes32;

    // not necessary
    receive() external payable {}

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

    // Get the supported  Callback Functions
    function getSupportedCallbackFunctions()
        public
        pure
        override
        returns (SupportedCallbackFunction[] memory supportedCallbackFunctions)
    {
        supportedCallbackFunctions = new SupportedCallbackFunction[](1);
        supportedCallbackFunctions[0] = SupportedCallbackFunction({
            selector: BeforeMintCallbackERC20.beforeMintERC20.selector,
            mode: CallbackMode.OPTIONAL
        });
    }

    function _beforeMint(address to, uint256 amount, bytes calldata data) internal virtual {
        _executeCallbackFunction(
            BeforeMintCallbackERC20.beforeMintERC20.selector,
            abi.encodeCall(BeforeMintCallbackERC20.beforeMintERC20, (to, amount, data))
        );
    }

    // Basic mint function
    function mint(address to, uint256 amount, bytes calldata data) external payable {
        _beforeMint(to, amount, data);
        _mint(to, amount);
    }
}
