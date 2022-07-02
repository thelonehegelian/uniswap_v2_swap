const { expect } = require("chai");
const { ethers } = require("hardhat");

// WETH9, DAI, USDC contracts
// interfaces for DAI and USDC is included in the Uniswap package installed
const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
const USDC = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";

// Interface defined in interfaces folder
const WETH9 = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2";



describe("Swap", function () {
  it("Should deploy the swap contract", function () {
      // get accounts 
    const [owner, acc1] = await ethers.getSigners();
    console.log(owner.address)
    // // get dai contract 
    // const dai = await ethers.getContractAt("IERC20", DAI);
    // const weth = await ethers.getContractAt("IWETH", WETH9);
    // const Swap = await ethers.getContractFactory("Swap");
    // const swap = await Swap.deploy();

    // // deploy the contract
    // await swap.deployed();
    // console.log(swap)
  });

  // it("Should make a single hop swap between two tokens", async function () {

  //   // get accounts 
  //   const [owner, acc1] = await ethers.getSigners();

  //   // get dai contract 
  //   const dai = await ethers.getContractAt("IERC20", DAI);
  //   const weth = await ethers.getContractAt("IWETH", WETH9);
  //   const Swap = await ethers.getContractFactory("Swap");
  //   const swap = await Swap.deploy();

  //   // deploy the contract
  //   await swap.deployed();

  //   console.log(swap.address);
  //   // expect swap.address is not equal to undefined

  //   // amount of ETH to be converted to DAI
  //   const amountIn = 1000;

  //   // deposit wethto the send
  //   await weth.connect(owner).deposit({value: amountIn }); 
  //   // approve the transaction, this is probably not necessary but lets see
  //   await weth.connect(owner).approve(swapExamples.address, amountIn);

  //   // make the swap, 
  //   await swap.swapExactInputSingle(amountIn, WETH9, DAI);

  //   // should get dai tokens for the eth spent
  //   console.log("DAI Balance", await dai.balanceOf(owner.address));
  // });
});
