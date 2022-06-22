<template>
  <div>
    <div id="vditor"/>
  </div>
</template>

<script>
import Vditor from "vditor";
import 'vditor/dist/index.css'
import {getToken} from "@/utils/auth";

export default {
  name: "QyEditor",
  props: {
    value: {//父组件传过来的值
      type: Object,
      default: () => {
        return {};
      }
    },
    options: {
      type: Object,
      default: () => {
        return {};
      }
    },
    comment: {//是否启用评论模式，默认不启用
      type: Boolean,
      default: false,
    },
    maxLength: {
      type: Number,
      default: 100000,
    }
  },
  data() {
    return {
      editor: null,//编辑器实例
      content: {
        text: this.value.text,
        html: this.value.html,
      },//编辑器的值，赋予初始值
      uploadUrl: process.env.VUE_APP_BASE_API + "/common/uploads", // 上传的图片服务器地址
      headers: {
        Authorization: "Bearer " + getToken(),
      },
    }
  },
  computed: {},
  watch: {
    value: {
      handler(newVal, oldVal) {
        if (this.editor) {
          this.editor.setValue(newVal.text);
          this.$forceUpdate()
        }
      },
      deep: true,
      immediate: true,
    },
  },
  mounted() {
    //完整配置参考https://ld246.com/article/1549638745630
    this.editor = new Vditor('vditor', {
      height: 360,
      minHeight: 300,
      width: '100%',
      placeholder: "请在此输入内容",
      lang: 'zh_CN',
      typewriterMode: false,//是否启用打字机模式
      // cdn: "",//使用自己的vditor相关资源的cdn地址
      value: this.content.text,//设置默认初始内容
      icon: "ant",//图标风格ant material
      toolbarConfig: {
        pin: true,
      },
      input: value => {//持续修改内容时，content和value值一致
        this.content.text = value;
        this.content.html = this.editor.getHTML();
        this.$emit("input", this.content)
      },
      focus: value => {//聚焦后触发

      },
      blur: value => {//失去焦点后触发，
        this.content.text = value;
        this.content.html = this.editor.getHTML();
        this.$emit("input", this.content)
      },
      esc: value => {//按下esc后触发

      },
      select: value => {//选中文字后触发

      },
      after: () => {//编辑器异步渲染完成后的回调方法

      },
      counter: {
        enable: true,//使用计数器
        max: this.maxLength,//最大字数
        type: 'markdown',//统计类型：'markdown', 'text'
        after: (length, counter) => {//字数统计回调
          if (length > counter.max) {
            this.$modal.msgWarning("字数超出限制，请修改");
          }
        }
      },
      cache: {
        enable: false,//不使用缓存
      },
      comment: {
        enable: this.comment,//是否使用评论模式
      },
      preview: {
        hljs: {
          enable: true,//使用代码高亮
          style: "dracula",//fruity monokai native rrt 参考：https://xyproto.github.io/splash/docs/longer/all.html?utm_source=ld246.com
          lineNumber: true,//启用行号
        }
      },
      upload: {
        url: this.uploadUrl,
        max: 1024 * 1024 * 1024,
        headers: this.headers,
        multiple: true,//上传多个文件
        fieldName: "files",//上传字段名
        format: (files, responseText) => {
          // console.log(files)
          // console.log(responseText)
        },
        validate: (files) => {
          // console.log("validate")
          // console.log(files)
        },

      },
      ...this.options//传入的配置会覆盖原有配置
    })
  },
  beforeDestroy() {
    this.editor.destroy();
    this.editor = null;
  },
  methods: {},
};
</script>

<style scoped lang="scss">

</style>
