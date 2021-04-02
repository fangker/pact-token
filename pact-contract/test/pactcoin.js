const { firstReserveWalletAddr } = require("../account-config");
const { communityReserveWalletAddr } = require("../account-config");
const { HNumber } = require("../utils/number");
const PactToken = artifacts.require("PactToken");
const { HBase } = require("../utils/number");

contract('PactToken', (accounts) => {
  let pactTokenInstance;
  before(async () => {
    const deployer = accounts[0];
    pactTokenInstance = await PactToken.deployed([communityReserveWalletAddr, firstReserveWalletAddr], { deployer, initializer: 'initialize' });
  });
  it('should put token in the reserve account', async () => {
    const groupBalance = await pactTokenInstance.balanceOf.call(accounts[0]);
    const communityBalance = await pactTokenInstance.balanceOf.call(communityReserveWalletAddr);
    const firstBalance = await pactTokenInstance.balanceOf.call(firstReserveWalletAddr);
    assert(HNumber(firstBalance).isEqualTo(50000000) && HNumber(communityBalance).isEqualTo(20000000), HNumber(groupBalance).isEqualTo(30000000))
  });
  it('should send coin correctly', async () => {
    const pactTokenInstance = await PactToken.deployed();
    const accountOne = accounts[0];
    const accountTwo = accounts[1];
    const accountOneBefore = HNumber(await pactTokenInstance.balanceOf.call(accountOne));
    await pactTokenInstance.transfer(accountTwo, HBase(2), { from: accountOne })
    // Setup 2 accounts.
    const accountOneAfter = HNumber(await pactTokenInstance.balanceOf.call(accountOne));
    assert(accountOneBefore - accountOneAfter === 2)
  });
});
