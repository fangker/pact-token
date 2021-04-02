'use strict';
const { HShow } = require("../utils/number");
const { firstReserveWalletAddr, communityReserveWalletAddr, developer } = require("../account-config");
const { sleep } = require("../utils/sleep");
const { HNumber } = require("../utils/Number");
const { HBase } = require("../utils/Number");
const PactToken = artifacts.require("PactToken");
const Farm = artifacts.require("Farm");
const PExactPool = artifacts.require("PExactPool");
contract('PactToken', (accounts) => {
  let pactTokenInstance;
  let farmInstance;
  let pExactPoolInstance;
  let deployer = developer;
  before(async () => {
    pactTokenInstance = await PactToken.deployed([communityReserveWalletAddr, firstReserveWalletAddr], { deployer, initializer: 'initialize' });
    farmInstance = await Farm.deployed([deployer, pactTokenInstance.address], { deployer, initializer: 'initialize' });
    pExactPoolInstance = await PExactPool.deployed([deployer, farmInstance.address, pactTokenInstance.address], { deployer, initializer: 'initialize' });
  });
  it('farm init', async () => {
    // deplover-> farm
    await pactTokenInstance.transfer(farmInstance.address, HBase(4000), { from: deployer })
    await farmInstance.approvePool(pExactPoolInstance.address, HBase(2000), { from: deployer });
    await farmInstance.approveToken(pactTokenInstance.address, pExactPoolInstance.address, HBase(2000), { from: deployer });
    const allwance = await pactTokenInstance.allowance(farmInstance.address, pExactPoolInstance.address);
    assert(HNumber(allwance).isEqualTo(2000), "allowance");
    // user logic
    await pactTokenInstance.transfer(accounts[5], HBase(120), { from: deployer });
    await pactTokenInstance.approve(pExactPoolInstance.address, HBase(120), { from: accounts[5] });
    // config
    await pExactPoolInstance.setHarvestSpan(60, false, { from: deployer });
    await pExactPoolInstance.farming(accounts[5], HBase(120), { from: accounts[5] });
    const totalStaking = await pExactPoolInstance.totalStaking();
    const span = await pExactPoolInstance.span();
    assert(HNumber(totalStaking).isEqualTo(120), span.toNumber() === 60);
    sleep(10000)
    const capacity = await pExactPoolInstance.harvestCapacity(accounts[5])
    assert(HShow(capacity) > 200);
    await pExactPoolInstance.harvest(accounts[5], { from: accounts[5] });
    const a = await pactTokenInstance.balanceOf(accounts[5]);
    assert(HShow(a) > 100);
  })
})
