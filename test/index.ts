import { expect } from "chai";
import { ethers } from "hardhat";

// interfaces for DAI and USDC is included in the Uniswap package installed
const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
const USDC = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";

// Interface defined in interfaces folder
const WETH9 = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2";

// some other ERC20 tokens
const MATIC = "0x6cb9daff67f07a93da266e81757cd1436cb3656d";
const AVAX = "0x93567d6b6553bde2b652fb7f197a229b93813d3f";
const MKR = "0xd61eaa2d5d7f9a92060d596a49c03be162e760a8";
const KINGSHIB = "0xa2ae4fb167e082242c0a5964065a9660db23ad35";
const WISE = "0x66a0f676479cee1d7373f3dc2e2952778bff5bd6";

describe("Swap", function () {
  it("Should deploy the swap contract", async function () {
    // get accounts
    const Swap = await ethers.getContractFactory("Swap");
    const swap = await Swap.deploy();

    await swap.deployed();
  });

  it("Should make a single hop swap between two tokens, WETH9 and DAI", async function () {
    // get accounts
    const [owner] = await ethers.getSigners();

    // get dai contract
    const dai = await ethers.getContractAt("IERC20", DAI);
    const weth = await ethers.getContractAt("IWETH", WETH9);
    const Swap = await ethers.getContractFactory("Swap");
    const swap = await Swap.deploy();

    // deploy the contract
    await swap.deployed();
    // amount of ETH to be converted to DAI
    const amountIn = 100;
    // here DAI balance is 0
    const initialDaiBalance = 0;
    /// NOTE: probably don't need to do it here as the contract function does that for us
    // deposit wethto the send
    await weth.connect(owner).deposit({ value: 5000 });
    await weth.connect(owner).approve(swap.address, amountIn);
    await swap.singleSwap(WETH9, DAI, amountIn, 1, owner.address);
    // now you have DAI to spend
    expect(await dai.balanceOf(owner.address)).to.not.equal(initialDaiBalance);
  });
});
