import axios from '../../plugins/axios'

const state = {
  myTracks: []
}

const getters = {
  myTracks: state => state.myTracks
}

const mutations = {
  setTracks: (state, tracks) => {
    state.myTracks = tracks
  },

  addTrack: (state, track) => {
    state.myTracks.push(track)
  },

  deleteTrack: (state, deleteTrack) => {
    state.myTracks = state.myTracks.filter(track => {
      return track.id != deleteTrack.id
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
    const deleteTrack = state.myTracks.filter(myTrack => {
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