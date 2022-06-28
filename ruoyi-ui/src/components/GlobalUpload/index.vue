<template>
  <uploader ref="uploader" :options="options" class="uploader"
            @file-added="addFile"
            @files-added="addFiles"
            @file-success="onFileSuccess"
            @file-progress="onFileProgress"
            @file-error="onFileError"
            @file-complete="onFileComplete"
            @upload-start="uploadStart"
  >
    <uploader-unsupport>
      此浏览器不支持此上传功能
    </uploader-unsupport>
    <uploader-drop v-if="showDrop"><!--拖拽上传区域-->
      <p>拖拽文件到这里上传或者</p>
      <uploader-btn>选择文件</uploader-btn>
      <uploader-btn :directory="true">选择目录</uploader-btn>
    </uploader-drop>
    <uploader-list #default="{fileList}">
      <el-popover
        v-model="showFileList"
        placement="top-start"
        trigger="click"
        width="480"
        title="文件列表"
      >
        <div class="pop-body">
          <div class="pop-content">
            <div v-for="(file,index) in fileList" :key="index">
              <uploader-file :file="file" :list="true">
              </uploader-file>
            </div>
            <div class="no-file" v-if="!fileList.length"><i class="nucfont inuc-empty-file"></i> 暂无待上传文件</div>
          </div>
        </div>
        <el-button slot="reference" class="pop-btn" type="primary" plain>上传列表<i
          class="el-icon-upload el-icon--right"></i></el-button>
      </el-popover>
    </uploader-list>
  </uploader>
</template>

<script>
import {getToken} from "@/utils/auth";
import SparkMD5 from "spark-md5";
import {mergeFile} from "@/api/net-disc/upload";

export default {
  data() {
    return {
      showDrop: false,//不显示拖拽区域
      chunkSize: 1024 * 1024, //分片大小，1MB
      storageId: 1,//存储方式，默认为1
      parentId: -1,//上传到此id对应的目录
      showFileList: false,//默认不显示文件上传列表
      options: {
        target: process.env.VUE_APP_BASE_API + "/net-disc/patchUpload",
        testChunks: true,//测试分片是否存在，用于秒传
        chunkSize: this.chunkSize,
        simultaneousUploads: 10, //并发上传数
        maxChunkRetries: 0,//最大重试次数
        headers: {'Authorization': 'Bearer ' + getToken()},
        fileParameterName: 'file',
        autoStart: false,//不自动上传
        forceChunkSize: true,
        fileStatusText: {
          success: '成功',
          error: '失败',
          uploading: '上传中',
          paused: '暂停',
          waiting: '正在计算MD5值'
        },
        query: (file, chunk) => {
          console.log(file)
          return {
            storageId: this.storageId,//存储方式，默认为1
            parentId: this.parentId,//上传到此id对应的目录
            fileName: file.name,
            randomKey: file.randomKey,
          }
        },
        // 服务器分片校验函数
        checkChunkUploadedByResponse: (chunk, response) => {
          let res = JSON.parse(response);
          return res.code === 200;
        },
        parseTimeRemaining: function (timeRemaining, parsedTimeRemaining) {
          return parsedTimeRemaining
            .replace(/\syears?/, '年')
            .replace(/\days?/, '天')
            .replace(/\shours?/, '小时')
            .replace(/\sminutes?/, '分钟')
            .replace(/\sseconds?/, '秒')
        }
      },
    }
  },
  mounted() {
    this.$store.dispatch('uploader/setGlobalUploader', this);
    this.$store.dispatch('uploader/setUploader', this.$refs["uploader"].uploader);
  },
  methods: {
    randomNum(n) {
      let str = "";
      for (let i = 0; i < n; i++) {
        str += Math.floor(Math.random() * 10);
      }
      return str;
    },
    addFile(file) {
      this.computedMD5(file);

    },
    addFiles(files) {
      const randomKey = Date.now() + this.randomNum(10);
      for (let file of files) {
        file.randomKey = randomKey;
      }
      this.showFileList = true;
    },
    computedMD5(file) {
      let fileReader = new FileReader();
      let time = new Date().getTime();
      let blobSlice = File.prototype.slice || File.prototype.mozSlice || File.prototype.webkitSlice;
      let currentChunk = 0;
      let chunks = Math.ceil(file.size / this.chunkSize);//总的片数
      let spark = new SparkMD5.ArrayBuffer();
      // 文件状态设为"计算MD5"
      // this.statusSet(file.id, 'md5');
      file.pause();//暂停
      loadNext();
      fileReader.onload = (e => {
        spark.append(e.target.result);
        if (currentChunk < chunks) {
          currentChunk++;
          loadNext();
          // 实时展示MD5的计算进度
          this.$nextTick(() => {
            // window.document.querySelector(`.myStatus_${file.id}`).innerText('校验MD5 ' + ((currentChunk / chunks) * 100).toFixed(0) + '%')
            // console.log('校验MD5 ' + ((currentChunk / chunks) * 100).toFixed(0) + '%')
          })
        } else {
          let md5 = spark.end();
          file.uniqueIdentifier = md5;//把md5赋值给上传参数
          file.resume();//恢复上传
          // this.statusRemove(file.id);
          console.log(`MD5计算完毕：${file.name} \nMD5：${md5} \n分片：${chunks} 大小:${file.size} 用时：${new Date().getTime() - time} ms`);
        }
      });
      fileReader.onerror = function () {
        this.error(`文件${file.name}读取出错，请检查该文件`)
        file.cancel();
      };

      const chunkSize = this.chunkSize;

      function loadNext() {
        let start = currentChunk * chunkSize;
        let end = ((start + chunkSize) >= file.size) ? file.size : start + chunkSize;
        fileReader.readAsArrayBuffer(blobSlice.call(file.file, start, end));
      }
    },

    statusSet(id, status) {
      let statusMap = {
        md5: {
          text: '校验MD5',
          bgc: '#fff'
        },
        merging: {
          text: '合并中',
          bgc: '#e2eeff'
        },
        transcoding: {
          text: '转码中',
          bgc: '#e2eeff'
        },
        failed: {
          text: '上传失败',
          bgc: '#e2eeff'
        }
      }
    },
    onFileSuccess(rootFile, file, response, chunk) {
      let res = JSON.parse(response);
      console.log("========================" + res)
      if (res.code === 200) {//上传成功
        // 如果服务端返回需要合并
        if (res.data.needMerge) {
          const param = {
            storageId: this.storageId,//存储方式，默认为1
            parentId: this.parentId,//上传到此id对应的目录
            fileName: file.name,
            identifier: file.uniqueIdentifier,
            relativePath: file.relativePath,
            totalChunks: file.chunks.length,
            chunkSize: this.chunkSize,
            totalSize: file.size,
            randomKey: file.randomKey,
          };
          mergeFile(
            param
          ).then(data => {
            // 文件合并成功
            this.$message("合并成功")
          }).catch(e => {
            this.$message("合并失败")
          });
        } else {// 不需要合并
          // Bus.$emit('fileSuccess', res);
          console.log('上传成功');
        }
      } else {//上传失败
        this.$modal.msgError("上传失败:" + res.msg);//todo 界面显示的success需要修改状态
      }
    },
    uploadStart() {

    },
    onFileComplete(rootFile) {
      console.log("onFileComplete")
      console.log(rootFile)
    },
    onFileError(rootFile, file, response, chunk) {
      console.log(error)
    },
    onFileProgress(rootFile, file, chunk) {
      // console.log(`上传中 ${file.name}，chunk：${chunk.startByte / 1024 / 1024} ~ ${chunk.endByte / 1024 / 1024}`)
    },
    de(delay) {
      let start = (new Date()).getTime();
      while ((new Date()).getTime() - start < delay) {
      }
    },
  }
}
</script>

<style scoped lang="scss">
.uploader {
  width: 100%;
  padding: 15px;
  font-size: 12px;

  .uploader-drop {
    background-color: #FFFFFF;
  }

  .pop-btn {
    position: fixed;
    bottom: 20px;
    right: 20px;
  }
}

.pop-body {
  height: 450px;
  width: 100%;

  .pop-content {
    height: 100%;
    width: 100%;
    overflow: auto;

    .no-file {
      //没有文件时的样式
    }
  }
}


</style>
