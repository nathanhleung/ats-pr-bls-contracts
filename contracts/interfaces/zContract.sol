// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface zContract {
    function onCrossChainCall(
        address zrc20,
        uint256 amount,
        bytes calldata message
    ) external;
}