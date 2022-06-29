<template>
  <div ref="upload-drag" class="upload-drag" v-show="isShow">
    {{ message }}
  </div>
</template>

<script>

export default {
  name: "QyModal",
  data() {
    return {
      isShow: false,
      message: "",
    };
  },
  mounted() {
    window.document.body.ondragenter = () => {
      if (!this.$modal.getUploadModalStatus()) {
        this.$modal.showUploadModal();
      }
    }
    this.$refs["upload-drag"].ondragleave = () => {
      if (this.$modal.getUploadModalStatus()) {
        this.$modal.closeUploadModal();
      }
    }
    this.$refs["upload-drag"].ondrop = () => {
      if (this.$modal.getUploadModalStatus()) {
        this.$modal.closeUploadModal();
      }
    }
  },
  computed: {},
  methods: {},
}
</script>

<style scoped lang="scss">
@media (min-width: 0px) {
  .upload-drag {
    font-size: 20px;
  }
}

@media (min-width: 300px) {
  .upload-drag {
    font-size: 25px;
  }
}

@media (min-width: 500px) {
  .upload-drag {
    font-size: 30px;
  }
}

@media (min-width: 800px) {
  .upload-drag {
    font-size: 35px;
  }
}

@media (min-width: 1100px) {
  .upload-drag {
    font-size: 40px;
  }
}

@media (min-width: 1500px) {
  .upload-drag {
    font-size: 50px;
  }
}

.upload-drag {
  position: absolute;
  background: hsla(0, 0%, 100%, .6);
  padding: 0;
  margin: 0;
  outline: 0;
  border: 3px dashed #ccc;
  z-index: 1000000;
  width: 100%;
  height: 100%;
  line-height: 100%;
  top: 0;
  left: 0;
  color: #999;
  text-align: center;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  box-sizing: border-box;
}
</style>
