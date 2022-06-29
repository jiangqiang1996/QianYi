const rootDir = {fileId: 0, fullFileName: "根目录"}
const state = {
  globalUploader: null,//全局上传组件
  uploader: null,//simple-uploader实例
  path: [
    rootDir
  ]//存储目录路径id
}

const mutations = {
  SET_GLOBAL_UPLOADER: (state, globalUploader) => {
    state.globalUploader = globalUploader
  },
  SET_UPLOADER: (state, uploader) => {
    state.uploader = uploader
  },
  PUSH_LAST_FILE: (state, file) => {
    state.path.push(file)
  },
  CLEAR_PATH: (state) => {
    state.path = [rootDir]
  }
}

const actions = {
  setGlobalUploader({commit}, globalUploader) {
    commit('SET_GLOBAL_UPLOADER', globalUploader)
  },
  setUploader({commit}, uploader) {
    commit('SET_UPLOADER', uploader)
  },
  pushLastFile({commit}, file) {
    commit('PUSH_LAST_FILE', file)
  },
  //获取当前目录对象
  getLastFile({state}) {
    return new Promise(resolve => {
      resolve(state.path[state.path.length - 1])
    })
  },
  //获取并取出当前目录对象
  popLastFile({state}) {
    return new Promise(resolve => {
      if (state.path.length > 1) {
        resolve(state.path.pop());
      } else {
        resolve();
      }
    });
  },
  clearPath({commit}) {
    commit('CLEAR_PATH')
  },
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
