const config = require("../../account-config");
const { communityReserveWalletAddr, firstReserveWalletAddr, developer } = config;
const PactToken = artifacts.require("PactToken");
const { deployProxy } = require('@openzeppelin/truffle-upgrades');
const Farm = artifacts.require("Farm");

module.exports = async function(deployer) {
  const pt = await deployProxy(PactToken, [communityReserveWalletAddr, firstReserveWalletAddr], { deployer, initializer: 'initialize' });
  await deployProxy(Farm, [developer, pt.address], { deployer, initializer: 'initialize' });
};

