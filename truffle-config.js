const HDWalletProvider = require('@truffle/hdwallet-provider');
const fs = require('fs');
module.exports = {
  networks: {
    inf_Uniswap_goerli: {
      network_id: 5,
      gasPrice: 100000000000,
      provider: new HDWalletProvider(fs.readFileSync('c:\\Users\\Rahul Prasad\\Desktop\\uniswap-clone-infura-youtube\\.env', 'utf-8'), "https://goerli.infura.io/v3/5303f0f79f394e178a9eee204c8df57d")
    }
  },
  mocha: {},
  compilers: {
    solc: {
      version: "0.8.17"
    }
  }
};
