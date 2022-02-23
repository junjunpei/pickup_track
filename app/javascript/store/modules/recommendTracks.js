import axios from '../../plugins/axios'

const state = {
  recommendTracks: []
}

const getters = {
  recommendTracks: state => state.recommendTracks
}

const mutations = {
  setRecommendTracks: (state, tracks) => {
    state.recommendTracks = tracks
  }
}

const actions = {
  fetchRecommendTracks({ commit }, track) {
    axios.get(`tracks/${track.id}/recommend`)
      .then(response => {
        commit("setRecommendTracks", response.data)
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