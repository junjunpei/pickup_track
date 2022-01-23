import axios from '../../plugins/axios'

const state = {
  historyTracks: []
}

const getters = {
  historyTracks: state => state.historyTracks
}

const mutations = {
  addHistory: (state, track) => {
    state.historyTracks.push(track)
  },
}

const actions = {
  addHistory({ commit }, addHistoryTrack) {
    return axios.post('histories', addHistoryTrack)
      .then(response => {
        commit('addHistory', response.data)
      })
  },
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}