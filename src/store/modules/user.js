const user = {
  account: "",
  select: false,
}

export const userStore = {
  namespaced:true,
  state: user,
  mutations: {
    commitAccount(state, _state) {
      state.account = _state.account;
      state.select = _state.select;
    }
  },
  actions: {
    commitAccount({ commit }, state) {
      console.log('commitAccount Action being executed')
      commit('commitAccount', state)
    }
  }
}
export default userStore;
