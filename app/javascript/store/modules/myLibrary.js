import axios from '../../plugins/axios'

const state = {
  myLibrary: []
}

const getters = {
  myLibrary: state => state.myLibrary
}

const mutations = {
  setTracks: (state, tracks) => {
    state.myLibrary = tracks
  },

  addTrack: (state, track) => {
    state.myLibrary.push(track)
  },

  deleteTrack: (state, deleteTrack) => {
    state.myLibrary = state.myLibrary.filter(myTrack => {
      return myTrack.id != deleteTrack.id
    })
  }
}

const actions = {
  fetchTracks({ commit }) {
    axios.get('tracks')
      .then(response => {
        commit('setTracks', response.data)
      })
      .catch(error => console.log(error.status))
  },

  createTrack({ commit }, trackId) {
    return axios.post('tracks', { track_id: trackId})
      .then(response => {
        commit('addTrack', response.data)
      })
  },

  deleteTrack({ commit, state }, trackId) {
    const deleteTrack = state.myLibrary.filter(myTrack => {
      return myTrack.track_id.indexOf(trackId) != -1
    })

    return axios.delete(`tracks/${deleteTrack[0].id}`, deleteTrack)
      .then(response => {
        commit('deleteTrack', response.data)
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