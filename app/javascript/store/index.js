import Vue from 'vue'
import Vuex from 'vuex'
import flashMessages from './modules/flashMessages'
import users from './modules/users'
import tracks from './modules/tracks'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    flashMessages,
    users,
    tracks
  }
})
