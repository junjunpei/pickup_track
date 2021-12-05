import axios from '../../plugins/axios'

const state = {
  tracks: []
}

const getters = {
  tracks: state => state.tracks
}

const mutations = {
  setTracks(state, tracks) {
    state.tracks = tracks
  }
}

const actions = {
  searchTracks({ commit }, search) {
    return axios.post('tracks/search', { search: search })
      .then(response => {
        commit('setTracks', response.data)
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