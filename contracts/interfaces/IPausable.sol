// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

interface IPausable {
    function paused() external view returns (bool);
}
