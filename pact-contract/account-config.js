const configs = require("./truffle-config.js");
const depover = configs.networks[process.env.network].provider();


module.exports = {
  developer: depover.addresses[0],
  communityReserveWalletAddr: depover.addresses[1],
  firstReserveWalletAddr: depover.addresses[2],
}
