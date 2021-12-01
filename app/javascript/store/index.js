import Vue from 'vue'
import Vuex from 'vuex'
import flashMessages from './modules/flashMessages'
import users from './modules/users'
import searchTracks from './modules/searchTracks'
import myTracks from './modules/myTracks'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    flashMessages,
    users,
    searchTracks,
    myTracks
  }
})
