// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

import '../WeswapPair.sol';
    
contract Utils {
    function initcodehash() external pure returns(bytes32 bytecode) {
        bytecode = keccak256(type(WeswapPair).creationCode);
    }

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function _sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'WeswapLibrary: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'WeswapLibrary: ZERO_ADDRESS');
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(address factory, address tokenA, address tokenB) external pure returns (address pair) {
        (address token0, address token1) = _sortTokens(tokenA, tokenB);
        pair = address(uint160(uint256(
            keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'0dfc769582080bd7a3b3e92e782a1b51a0fe1affbbdabfa4ada017a58d3c5712' // init code hash
            ))
        )));
    }
}
