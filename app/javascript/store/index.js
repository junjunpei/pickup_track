import Vue from 'vue'
import Vuex from 'vuex'
import flashMessages from './modules/flashMessages'
import users from './modules/users'
import searchTracks from './modules/searchTracks'
import myLibrary from './modules/myLibrary'
import historyTracks from './modules/historyTracks'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    flashMessages,
    users,
    searchTracks,
    myLibrary,
    historyTracks
  }
})
