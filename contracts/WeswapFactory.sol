// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./interfaces/IWeswapFactory.sol";
import "./WeswapPair.sol";

contract WeswapFactory is IWeswapFactory, Ownable {
    address public feeTo;
    address public feeToSetter;

    address public breaker;
    address public breakerSetter;

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    mapping(address => bool) public whitelist;

    constructor(
        address _feeToSetter,
        address _breakerSetter
    ) {
        feeToSetter = _feeToSetter;
        breakerSetter = _breakerSetter;
    }

    function allPairsLength() external view returns (uint256) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair)
    {
        require(tokenA != tokenB, "Weswap: IDENTICAL_ADDRESSES");
        (address token0, address token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);
        require(token0 != address(0), "Weswap: ZERO_ADDRESS");
        require(getPair[token0][token1] == address(0), "Weswap: PAIR_EXISTS"); // single check is sufficient
        bytes memory bytecode = type(WeswapPair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IWeswapPair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, "Weswap: FORBIDDEN");
        address prevFeeTo = feeTo;
        feeTo = _feeTo;
        emit SetFeeTo(prevFeeTo, feeTo);
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, "Weswap: FORBIDDEN");
        address prevFeeToSetter = feeToSetter;
        feeToSetter = _feeToSetter;
        emit SetFeeToSetter(prevFeeToSetter, feeToSetter);
    }

    function setBreaker(address _breaker) external {
        require(msg.sender == breakerSetter, "Weswap: FORBIDDEN");
        address prevBreaker = breaker;
        breaker = _breaker;
        emit SetBreaker(prevBreaker, breaker);
    }

    function setBreakerSetter(address _breakerSetter) external {
        require(msg.sender == breakerSetter, "Weswap: FORBIDDEN");
        address prevBreakerSetter = breakerSetter;
        breakerSetter = _breakerSetter;
        emit SetBreakerSetter(prevBreakerSetter, breakerSetter);
    }

    /**
     * @dev Reverts if beneficiary is not whitelisted. Can be used when extending this contract.
     */
    modifier isWhitelisted(address _beneficiary) {
        require(whitelist[_beneficiary], "Weswap: INVALID_ADDRESS");
        _;
    }

    /**
     * @dev Adds single address to whitelist.
     * @param _beneficiary Address to be added to the whitelist
     */
    function addToWhitelist(address _beneficiary) public onlyOwner {
        whitelist[_beneficiary] = true;
        emit AddWhitelist(_beneficiary);
    }

    /**
     * @dev Removes single address from whitelist.
     * @param _beneficiary Address to be removed to the whitelist
     */
    function removeFromWhitelist(address _beneficiary) public onlyOwner {
        whitelist[_beneficiary] = false;
        emit RemoveWhitelist(_beneficiary);
    }
}
