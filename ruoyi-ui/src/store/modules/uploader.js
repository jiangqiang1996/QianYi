const state = {
  globalUploader: null,//全局上传组件
  uploader: null,//simple-uploader实例
  currentDirectory: null
}

const mutations = {
  SET_GLOBAL_UPLOADER: (state, globalUploader) => {
    state.globalUploader = globalUploader
  },
  SET_UPLOADER: (state, uploader) => {
    state.uploader = uploader
  },
  SET_CURRENT_DIRECTORY: (state, currentDirectory) => {
    state.currentDirectory = currentDirectory
  }

}

const actions = {
  setGlobalUploader({commit}, globalUploader) {
    commit('SET_GLOBAL_UPLOADER', globalUploader)
  },
  setUploader({commit}, uploader) {
    commit('SET_UPLOADER', uploader)
  },
  /*设置当前目录*/
  setCurrentDirectory({commit}, currentDirectory) {
    commit('SET_CURRENT_DIRECTORY', currentDirectory)
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
