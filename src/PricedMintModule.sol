// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Module} from "modular-contracts/src/Module.sol";
import {BeforeMintCallbackERC20} from "modular-contracts/src/callback/BeforeMintCallbackERC20.sol";

contract PricedMintModule is Module, BeforeMintCallbackERC20 {
    uint256 public constant mintPrice = 0.00000000001 ether;

    function getModuleConfig() external pure override returns (ModuleConfig memory config) {
        config.callbackFunctions = new CallbackFunction[](1);
        config.callbackFunctions[0] = CallbackFunction({selector: this.beforeMintERC20.selector});

        config.requiredInterfaces = new bytes4[](1);
        config.requiredInterfaces[0] = 0x01ffc9a7;
    }

    // function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
    //     return interfaceId == 0x01ffc9a7 // ERC165 Interface ID for ERC165
    //         || interfaceId == 0xe8a3d485 // ERC-7572
    //         || interfaceId == 0x7f5828d0 // ERC-173
    //         || interfaceId == type(IERC20).interfaceId || _supportsInterfaceViaModules(interfaceId);
    // }

    function beforeMintERC20(address _to, uint256 _amount, bytes memory _data)
        external
        payable
        virtual
        override
        returns (bytes memory result)
    {
        require(msg.value == mintPrice * _amount, "You need to  pay the correct fee");
    }
}
