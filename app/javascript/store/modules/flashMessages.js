const state = {
  message: "",
  type: "",
  status: false
}

const getters = {
  message: state => state.message,
  type: state => state.type,
  status: state => state.status
}

const mutations = {
  setFlashMessage(state, { message, type }) {
    state.message = message
    state.type = type
  },
  setStatus(state, status) {
    state.status = status
  }
}

const actions = {
  showMessage({ commit }, { message, type, status }) {
    commit("setFlashMessage", { message, type })
    commit("setStatus", status)
    setTimeout(() => {
      commit("setStatus", !status)
    }, 3000)
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
