<template>
    <div class="net-disc-content">
      <button ref="selectFile">选择文件</button>
      <button ref="selectDirectory">选择目录</button>
    </div>
</template>

<script>
import {mapGetters} from "vuex";

export default {
  name: "index",
  data() {
    return {
      items: [],
      fileList: null,
    }
  },
  created() {

  },
  mounted() {
    this.uploader.assignBrowse(this.$refs.selectFile, false)
    this.uploader.assignBrowse(this.$refs.selectDirectory, true)
  },
  computed: {
    ...mapGetters(["globalUploader", "uploader"]),
  },
  methods: {

  },
  destroyed() {
  },
}

</script>

<style scoped lang="scss">
.drag-drop {
  height: 100px;
  width: 100%;
  background-color: #fff555;
}
</style>
