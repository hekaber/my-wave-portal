require("@nomicfoundation/hardhat-toolbox");
const path = require('path');
require('dotenv').config({path:path.resolve(__dirname, './config/env/.env')});

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
      console.log(account.address);
  }
});

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    docker: {
      url:"http://0.0.0.0:8545",
    },
    goerli: {
      url: process.env.GOERLI_URL,
      accounts: [process.env.GOERLI_ACCOUNT_KEY]
    },
  }
};
