import QyModal from '@/components/QyModal';
import Vue from 'vue'
import router from "@/router";
import store from '@/store'

// 创建⼀个⼦类
const modalConstructor = Vue.extend(QyModal);
// 实例化这个⼦类
const instance = new modalConstructor();
// 创建⼀个div元素，并把实例挂载到div元素上
instance.$mount(document.createElement('div'));
// 将el插⼊到body元素中
document.body.appendChild(instance.$el);
export default {
  show: (message) => {
    if (router.currentRoute.name === 'Dir' && store.getters.currentDirectory) {
      instance.message = message ? message : "上传文件到当前目录：" + store.getters.currentDirectory;
    } else {
      instance.message = message ? message : "上传文件到根目录下";
    }
    instance.isShow = true;
  },
  close: () => {
    instance.isShow = false;
  },
  status: () => {
    return instance.isShow;
  },
  uploadModalInstance: () => {
    return instance;
  },

}
