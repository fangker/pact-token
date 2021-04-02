'use strict';
import Vue from 'vue'
import Vuex from 'vuex'
import chain from './modules/chain'
import user from "./modules/user";
Vue.use(Vuex)

export const store = new Vuex.Store({
  modules: {
    chain,
    user,
  }
})
