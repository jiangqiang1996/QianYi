const state = {
  globalUploader: null,//全局上传组件
  uploader: null//simple-uploader实例
}

const mutations = {
  SET_GLOBAL_UPLOADER: (state, globalUploader) => {
    state.globalUploader = globalUploader
  },
  SET_UPLOADER: (state, uploader) => {
    state.uploader = uploader
  }
}

const actions = {
  setGlobalUploader({commit}, globalUploader) {
    commit('SET_GLOBAL_UPLOADER', globalUploader)
  },
  setUploader({commit}, uploader) {
    commit('SET_UPLOADER', uploader)
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
