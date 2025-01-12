// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20Core} from "modular-contracts/src/core/token/ERC20Core.sol";

contract ERC20CoreContract is ERC20Core {
    constructor(
        string memory _name,
        string memory _symbol,
        string memory _contractURI,
        address _owner,
        address[] memory _modules,
        bytes[] memory _moduleInstallData
    ) ERC20Core(_name, _symbol, _contractURI, _owner, _modules, _moduleInstallData) {}

    receive() external payable {}
}
