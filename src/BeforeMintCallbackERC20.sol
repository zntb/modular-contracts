// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BeforeMintCallbackERC20 {
    function beforeMintERC20(address _to, uint256 _amount, bytes memory _data)
        external
        payable
        virtual
        returns (bytes memory result)
    {}
}
