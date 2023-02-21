// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.7.6;
pragma abicoder v2;

import {IUniswapV2Factory, IUniswapV2Router02} from "./interfaces/Interfaces.sol";
import "./interfaces/IERC20.sol";

/**
 * 1. Get swapRouter address
 * 2. Pass wthe swapRouter address to the ISwapRouter interface to get access to the contract functions
 * 3. Remove constructor function because swapRouter passed directly
 * 4. Update swapExactInputSingle to swap WETH9 to DAI
 */

contract Swap {
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    // TODO: Add swaprouter address to the constructor
    // constructor (address _swapRouterAddress) {}

    // TODO: Inherit the SwapRouter
    // TODO: pass the SwapRouter address as a constructor

    // TODO: Get v3 router. This is V2 router
    // Set swap router
    address private constant UNISWAP_V2_ROUTER =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    // set the pool fee to 0.3%.
    uint24 public constant poolFee = 3000;

    function singleSwap(
        address _token0,
        address _token1,
        uint256 _amountIn,
        uint256 _amountOutMin,
        address _to
    ) external {
        IERC20(_token0).transferFrom(msg.sender, address(this), _amountIn);
        IERC20(_token0).approve(UNISWAP_V2_ROUTER, _amountIn);

        address[] memory path = new address[](2);
        path[0] = address(_token0);
        path[1] = address(_token1);

        IUniswapV2Router02(UNISWAP_V2_ROUTER).swapExactTokensForTokens(
            _amountIn,
            _amountOutMin,
            path,
            _to,
            block.timestamp
        );
    }
}
