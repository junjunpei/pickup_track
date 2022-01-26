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

  deleteHistoryTrack: (state, deleteTrack) => {
    state.historyTracks = state.historyTracks.filter(track => {
      return track.id != deleteTrack.id
    })
  }
}

const actions = {
  fetchHistoryTracks({ commit }) {
    axios.get("histories")
      .then(response => {
        commit("setHistoryTracks", response.data)
      })
  },

  addHistoryTrack({ commit }, addTrack) {
    return axios.post("histories", addTrack)
      .then(response => {
        commit("addHistoryTrack", response.data)
      })
  },

  deleteHistoryTrack({ commit }, deleteTrack) {
    return axios.delete(`histories/${deleteTrack.id}`, deleteTrack)
      .then(response => {
        commit("deleteHistoryTrack", response.data)
      })
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}