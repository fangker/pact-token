const config = require("../../account-config");
const { HBase } = require("../../utils/number");
const { HShow } = require("../../utils/number");
const { communityReserveWalletAddr, firstReserveWalletAddr, developer } = config;
const PactToken = artifacts.require("PactToken");
const { deployProxy } = require('@openzeppelin/truffle-upgrades');
const Farm = artifacts.require("Farm");
const PExactPool = artifacts.require("PExactPool");

module.exports = async function(deployer) {
  const pactInstance = await deployProxy(PactToken, [deployer, communityReserveWalletAddr, firstReserveWalletAddr], { deployer, initializer: 'initialize' });
  const farmInstance = await deployProxy(Farm, [developer, pactInstance.address], { deployer, initializer: 'initialize' });
  const pExactPoolInstance = await deployProxy(PExactPool, [developer, farmInstance.address, pactInstance.address], { deployer, initializer: 'initialize' });
  console.log(`[1]========Pact Message======`);
  console.log(`PactInstance DeployerReserveWalletAddr Address: ${HShow(await pactInstance.balanceOf(developer))}`);
  console.log(`PactInstance CommunityReserveWalletAddr Address: ${HShow(await pactInstance.balanceOf(communityReserveWalletAddr))}`);
  console.log(`PactInstance FirstReserveWalletAddr Address: ${HShow(await pactInstance.balanceOf(firstReserveWalletAddr))}`);
  console.log(`[2]========Farm Config Message======`);
  await pactInstance.transfer(farmInstance.address, HBase(100000), { from: communityReserveWalletAddr });
  await farmInstance.approvePool(pExactPoolInstance.address, HBase(100000), { from: developer });
  await pExactPoolInstance.setHarvestSpan(3600 * 24 * 30, false, { from: developer })
  console.log(`[3]========Address Message======`);
  console.log(`PactInstance Address: ${pactInstance.address}`);
  console.log(`FarmInstance Address: ${farmInstance.address}`);
  console.log(`PExactPoolInstance Address: ${pExactPoolInstance.address}`);
};

