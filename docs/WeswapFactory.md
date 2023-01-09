## `WeswapFactory`





### `isWhitelisted(address _beneficiary)`



Reverts if beneficiary is not whitelisted. Can be used when extending this contract.


### `constructor(address _feeToSetter, address _breakerSetter)` (public)





### `allPairsLength() → uint256` (external)





### `createPair(address tokenA, address tokenB) → address pair` (external)





### `setFeeTo(address _feeTo)` (external)





### `setFeeToSetter(address _feeToSetter)` (external)





### `setBreaker(address _breaker)` (external)





### `setBreakerSetter(address _breakerSetter)` (external)





### `addToWhitelist(address _beneficiary)` (public)



Adds single address to whitelist.


### `removeFromWhitelist(address _beneficiary)` (public)



Removes single address from whitelist.



