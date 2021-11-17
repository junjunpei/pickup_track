import Vue from 'vue'
import Vuex from 'vuex'
import flashMessages from './modules/flashMessages'
import users from './modules/users'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    flashMessages,
    users
  }
})
