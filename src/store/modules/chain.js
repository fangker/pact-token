const chain = {
  web3: {},
  contractInstance: null,
}
import { cloneDeep } from "lodash";

export const chainStore = {
  namespaced:true,
  state: chain,
  mutations: {
    registerWeb3(state, _state) {
      state.web3 = cloneDeep(_state)
    }
  },
  actions: {
    registerWeb3({ commit }, state) {
      console.log('registerWeb3 Action being executed')
      commit('registerWeb3', state)
    }
  }
}
export default chainStore;
