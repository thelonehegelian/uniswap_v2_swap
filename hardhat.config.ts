import * as dotenv from "dotenv";

import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import chai from "chai";
import { solidity } from "ethereum-waffle";

chai.use(solidity);

// import "@typechain/hardhat";
// import "hardhat-gas-reporter";
// import "solidity-coverage";

dotenv.config();

module.exports = {
  solidity: "0.8.0",
  networks: {
    hardhat: {
      chainId: 31337,
      forking: {
        url: `https://eth-mainnet.g.alchemy.com/v2/${process.env.API_KEY}`,
        blockNumber: 14390000,
      },
    },
  },
};
