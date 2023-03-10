// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

interface IWeswapFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    event SetFeeTo(address from_, address to_);
    event SetFeeToSetter(address from_, address to_);
    event SetBreaker(address from_, address to_);
    event SetBreakerSetter(address from_, address to_);

    event AddWhitelist(address account);
    event RemoveWhitelist(address account);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function breaker() external view returns (address);
    function breakerSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint256) external view returns (address pair);
    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;

    function setBreaker(address _breaker) external;
    function setBreakerSetter(address _breakerSetter) external;

    function whitelist(address) external view returns (bool);
    function addToWhitelist(address _beneficiary) external;
    function removeFromWhitelist(address _beneficiary) external;
}
