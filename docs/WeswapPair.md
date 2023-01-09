## `WeswapPair`





### `lock()`





### `whenNotPausedOrWhitelist()`

*


Modifier to make a function callable
when the contract is not paused or is called from whitelisted address.

Requirements:

- The contract must not be paused.
- Or the caller must be whitelisted.
/

### `onlyWhitelist()`





### `userInfoUpdate(address account_)`






### `paused() → bool` (public)

*


Returns true if the contract is paused, and false otherwise.
/

### `pause()` (public)

*


Triggers stopped state.

Requirements:

- The contract must not be paused.
/

### `unpause()` (public)

*


Returns to normal state.

Requirements:

- The contract must be paused.
/

### `userInfoContract() → address` (external)





### `updateUserInfoContract(address newUserInfoContract)` (external)





### `disableUserInfoContract()` (external)





### `userInfo(address account_) → uint256, uint256, uint256` (external)





### `_updateUserInfo(address account_)` (internal)





### `getReserves() → uint112 _reserve0, uint112 _reserve1, uint32 _blockTimestampLast` (public)





### `initialize(address _token0, address _token1)` (external)





### `mint(address to) → uint256 liquidity` (external)





### `burn(address to) → uint256 amount0, uint256 amount1` (external)





### `transfer(address to, uint256 value) → bool res` (public)





### `transferFrom(address from, address to, uint256 value) → bool res` (public)





### `swap(uint256 amount0Out, uint256 amount1Out, address to, bytes data)` (external)





### `skim(address to)` (external)





### `sync()` (external)






