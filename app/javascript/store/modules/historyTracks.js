import axios from '../../plugins/axios'

const state = {
  historyTracks: []
}

const getters = {
  historyTracks: state => state.historyTracks
}

const mutations = {
  setHistoryTracks: (state, tracks) => {
    state.historyTracks = tracks
  },

  addHistoryTrack: (state, track) => {
    state.historyTracks.push(track)
  },
}

const actions = {
  fetchHistoryTracks({ commit }) {
    axios.get("histories")
      .then(response => {
        commit("setHistoryTracks", response.data)
      })
  },

  addHistoryTrack({ commit }, track) {
    return axios.post("histories", track)
      .then(response => {
        commit("addHistoryTrack", response.data)
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