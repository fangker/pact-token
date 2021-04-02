import Web3 from 'web3'
import { getChainConfig } from '../../config/chain'

const chainConfig = getChainConfig()
/*
* 1. Check for injected web3 (mist/metamask)
* 2. If metamask/mist create a new web3 instance and pass on result
* 3. Get networkId - Now we can check the user is connected to the right network to use our dApp
* 4. Get user account from metamask
* 5. Get user balance
*/
let web3Instance;
let loadWeb3 = async function(init) {
  // Check for injected web3 (mist/metamask)
  if (!web3Instance) {
    const webProvider = new Web3.providers.HttpProvider(chainConfig['rpcURL'])
    web3Instance = new Web3(webProvider);
  }
  const web3js = window.ethereum;
  if (web3Instance || init === true) {
    if (typeof web3js !== 'undefined') {
      web3Instance = new Web3(web3js)
      // emit
      web3js.on('chainChanged', () => {
        window.location.reload();
        ethereum.request({ method: 'eth_accounts' })
      });
      web3js.on('accountsChanged', () => {
        window.location.reload();
        ethereum.request({ method: 'eth_accounts' })
      });
    }
  }
  return web3Instance;
};
export default loadWeb3
