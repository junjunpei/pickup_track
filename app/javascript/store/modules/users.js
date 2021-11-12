import axios from '../../plugins/axios'

const state = {
  authUser: null
}

const getters = {
  authUser: state => state.authUser
}

const mutations = {
  setAuthUser(state, user) {
    state.authUser = user
  }
}

const actions = {
  loginUser({ commit }, user) {
    return axios.post("sessions", user)
      .then(response => {
        commit('setAuthUser', response.data)
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
