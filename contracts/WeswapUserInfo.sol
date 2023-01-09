// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./interfaces/IWeswapPair.sol";
import "./interfaces/IWeswapUserInfo.sol";
import "./interfaces/IERC20.sol";

contract WeswapUserInfo is IWeswapUserInfo, Ownable {
    mapping(address => UserInfo) private _userInfo;

    IWeswapPair internal immutable _pair;

    constructor(address pair_, address owner_) {
        _pair = IWeswapPair(pair_);
        _transferOwnership(owner_);
        emit Pair(pair_);
    }

    function pair() external view returns (address) {
        return address(_pair);
    }

    function getUserInfo(address account_)
        external
        view
        returns (
            uint256,
            uint256,
            uint256
        )
    {
        return (
            _userInfo[account_].reserve0,
            _userInfo[account_].reserve1,
            _userInfo[account_].wen
        );
    }

    function updateUserInfo(address account_) external onlyOwner {
        (uint112 _reserve0, uint112 _reserve1, ) = _pair.getReserves(); // gas savings
        uint256 totalSupply = IERC20(address(_pair)).totalSupply();
        uint256 balance = IERC20(address(_pair)).balanceOf(account_);

        if (totalSupply == 0) {
            // do not recored userInfo
            return;
        }
        if (account_ != address(0)) {
            // from
            UserInfo storage user = _userInfo[account_];
            user.reserve0 = (uint256(_reserve0) * balance) / totalSupply;
            user.reserve1 = (uint256(_reserve1) * balance) / totalSupply;
            user.wen = block.timestamp;
            emit User(account_, user.reserve0, user.reserve1, user.wen);
        }
    }
}
