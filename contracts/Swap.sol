// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import {IUniswapV2Factory} from "./interfaces/IUniswapV2Factory.sol";

/**
 * 1. Get swapRouter address
 * 2. Pass wthe swapRouter address to the ISwapRouter interface to get access to the contract functions
 * 3. Remove constructor function because swapRouter passed directly
 * 4. Update swapExactInputSingle to swap WETH9 to DAI
 */

contract Swap {
    // For the scope of these swap examples,
    // we will detail the design considerations when using
    // `exactInput`, `exactInputSingle`, `exactOutput`, and  `exactOutputSingle`.

    // It should be noted that for the sake of these examples, we purposefully pass in the swap router instead of inherit the swap router for simplicity.
    // More advanced example contracts will detail how to inherit the swap router safely.

    // TODO: Inherit the SwapRouter
    // TODO: pass the SwapRouter address as a constructor

    // Set swap router 
    ISwapRouter public constant swapRouter =
        ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);

    // For this example, we will set the pool fee to 0.3%.
    uint24 public constant poolFee = 3000;

    /// @notice swapExactInputSingle swaps a fixed amount of token0 for a maximum possible amount of token1

    /// @dev The calling address must approve this contract to spend at least `amountIn` worth of its DAI for this function to succeed.

    /// @param amountIn The exact amount of DAI that will be swapped for WETH9.
    /// @param token0   Address of the token to be provided
    /// @param token1   Address of the token to be received

    /// @return amountOut The amount of token0 received.

    // token0 is being swapped for token1
    // TODO: is using an array here better?
    // for testing, addresses passed would be 
        // token0 = WETH9 
        // token1 = DAI

    // After testing succeeds verify pools for the pair passed and then move on  
    function swapExactInputSingle(uint256 amountIn, address token0, address token1)
        external
        returns (uint256 amountOut)
    {	
    	// pass the factory address in the constructor
    	address factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
		address pairAddress = IUniswapV2Factory(factory).getPair(token0, token1);
    	
    	// TODO: test if the pool exists    	
	    require(pairAddress != address(0), 'A liquidity pool for token0 and token1 does not exist. Try a different address pair');
        
        // msg.sender must approve this contract. What does "approve" mean here?

        // there is also this way to do this, but calling swap method directly is not recommended
        // unless its a uniSwap flashloan
        // IUniswapV2Pair(pairAddress).swap ()

        // Transfer the specified amount of token0 to this contract.
        TransferHelper.safeTransferFrom(
            token0, 
            msg.sender,
            address(this),
            amountIn
        );

        // Approve the router to spend token0.
        TransferHelper.safeApprove(token0, address(swapRouter), amountIn);

        // Naively set amountOutMinimum to 0. In production, use an oracle or other data source to choose a safer value for amountOutMinimum.
        // We also set the sqrtPriceLimitx96 to be 0 to ensure we swap our exact input amount.
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: token0,
                tokenOut: token1,
                fee: poolFee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        // The call to `exactInputSingle` executes the swap.
        amountOut = swapRouter.exactInputSingle(params);
    }


}
