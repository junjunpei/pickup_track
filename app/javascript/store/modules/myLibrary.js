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

  addTrack({ commit }, addTrack) {
    return axios.post('tracks', addTrack)
      .then(response => {
        commit('addTrack', response.data)
      })
  },

  deleteTrack({ commit, state }, track) {
    const deleteTrack = state.myLibrary.filter(myTrack => {
      return myTrack.track_id.indexOf(track.track_id) != -1
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