'use strict';
const chainConfig = {
  development: {
    rpcURL: "http://127.0.0.1:8545",
    pactInstance: "0xC89Ce4735882C9F0f0FE26686c53074E09B0D550",
    frmInstance: "0x9561C133DD8580860B6b7E504bC5Aa500f0f06a7",
    pExactPoolInstance: "0x59d3631c86BbE35EF041872d502F218A39FBa150",
  }
}

exports.getChainConfig = () => {
  let chainEnv = process.env.network;
  if (!chainEnv) {
    chainEnv = 'development';
  }
  return chainConfig[chainEnv];
}
