<template>
  <div id="app">
    <router-view/>
    <!-- 将上传组件全局注册 登录之后再初始化上传组件-->
    <global-uploader v-if="token"></global-uploader>
  </div>
</template>

<script>
import globalUploader from '@/components/GlobalUpload'
import {mapGetters} from "vuex";

export default {
  name: 'App',
  components: {
    globalUploader
  },
  computed: {
    ...mapGetters(["token"]),
  },
  metaInfo() {
    return {
      title: this.$store.state.settings.dynamicTitle && this.$store.state.settings.title,
      titleTemplate: title => {
        return title ? `${title} - ${process.env.VUE_APP_TITLE}` : process.env.VUE_APP_TITLE
      }
    }
  }
}
</script>
