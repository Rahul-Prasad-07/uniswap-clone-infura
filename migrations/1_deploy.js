const uniswap = artifacts.require('uniswap');
module.exports = function(deployer){
    deployer.deploy(uniswap)
}