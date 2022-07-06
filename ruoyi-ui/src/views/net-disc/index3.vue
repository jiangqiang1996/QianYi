<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="100px">
      <el-form-item label="文件或目录名" prop="fileName">
        <el-input
          v-model="queryParams.fullFileName"
          placeholder="文件或目录名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>

      <el-form-item label="存储方式" prop="storageId">
        <el-input
          v-model="queryParams.storageId"
          placeholder="存储方式"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleDelete"
          v-hasPermi="['netdisc:files:add']"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleDelete"
          v-hasPermi="['netdisc:files:edit']"
        >新建文件夹
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['netdisc:files:remove']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['netdisc:files:export']"
        >下载
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>
    <el-row>
      <el-col :span="24">
        <button ref="selectFile" type="button" class="el-button el-button--default el-button--mini is-plain">
          <span>上传文件夹<i class="el-icon-upload el-icon--right"></i></span>
        </button>
        <button ref="selectDirectory" type="button" class="el-button el-button--default el-button--mini is-plain">
          <span>上传文件夹<i class="el-icon-upload el-icon--right"></i></span>
        </button>
      </el-col>
    </el-row>
    <el-row>
      <el-col :span="24">
        <el-button @click="returnParentDirectory">返回上一级</el-button>
        <el-button v-if="this.path.length>1" @click="returnHome">返回根目录</el-button>
        <el-button v-for="(item,index) in this.path" :key="index" @click="goToDir(index)">{{
            item.fullFileName
          }}
        </el-button>
      </el-col>
    </el-row>

    <avue-crud v-loading="loading" :data="filesList" :option="option"
               :data-size="filesList.length"
               @cell-dblclick="openDirectory"
    ></avue-crud>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
import {
  addFiles,
  delFiles,
  getFiles,
  listFiles,
  updateFiles
} from "@/api/net-disc/file";
import {mapActions, mapGetters, mapMutations} from "vuex";
export default {
  name: "Files",
  data() {
    return {

      option: {
        align: 'left',
        menuType: this.menuType,
        height: 300,
        selectionFixed: false,
        expandFixed: false,
        menuFixed: false,
        emptyText: '暂无文件，快去上传一个吧',
        size: "medium",
        selection: true,
        rowKey: "fileId",
        defaultSort: {prop: 'isDir', order: 'descending'},
        column: [
          {
            label: '文件名',
            prop: 'fullFileName',
            minWidth: 200,
            overHidden: true,
            sortable: true,
            click:(value,column)=>{
                if (column.property === "fullFileName") {
                  console.log(column)
                  if (column.isDir) {//双击目录名，打开目录
                    // this.pushLastFile(column)
                    // this.getList()
                  } else {
                    //双击文件名，预览文件
                  }
                }
            }
          },
          {
            label: '上传时间',
            prop: 'createTime',
            minWidth: 200,
            editDisabled: true,//不可编辑
            editDisplay: false,//编辑时不可见
          },
          {
            label: '修改时间',
            prop: 'updateTime',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
          },
          {
            label: '文件大小',
            prop: 'size',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            sortable: true,
            formatter: (row, value, label, column) => {
              if (value || value === 0) {
                if (value < 1024) {
                  return value + "B";
                } else if (value < 1024 * 1024) {
                  return value / 1024 + "KB"
                } else if (value < 1024 * 1024 * 1024) {
                  return value / 1024 / 1024 + "MB"
                } else if (value < 1024 * 1024 * 1024 * 1024) {
                  return value / 1024 / 1024 / 1024 + "GB"
                } else {
                  return value / 1024 / 1024 / 1024 / 1024 + "TB"
                }
              } else {
                return "-";
              }
            }
          },
          {
            label: 'id',
            prop: 'fileId',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: '文件名',//不包含后缀
            prop: 'fileName',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: '文件后缀',
            prop: 'suffix',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: '文件类型',
            prop: 'mimeType',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: '存储方式',
            prop: 'storageId',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: '服务端路径',
            prop: 'uploadPath',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: '文件的唯一key',
            prop: 'fileKey',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: '是否为目录',
            prop: 'isDir',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: '父级目录id',
            prop: 'parentId',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: '目录的随机key',
            prop: 'randomKey',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: '访问权限',
            prop: 'isPublic',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
          {
            label: 'MD5值',
            prop: 'identifier',
            minWidth: 200,
            editDisabled: true,
            editDisplay: false,
            hide: true,
          },
        ]
      },


      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 文件表格数据
      filesList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        fullFileName: null,
        suffix: null,
        size: null,
        mimeType: null,
        storageId: null,
        uploadPath: null,
        fileKey: null,
        isDir: null,
        parentId: null,
        randomKey: null,
        identifier: null,
        isPublic: null,
      }
    };
  },
  created() {
    this.getList();
  },
  mounted() {
    this.uploader.assignBrowse(this.$refs.selectFile, false)
    this.uploader.assignBrowse(this.$refs.selectDirectory, true)
  },
  computed: {
    ...mapGetters(["globalUploader", "uploader", "path"]),
  },
  methods: {
    ...mapMutations({
      clearPath: 'uploader/CLEAR_PATH',
      pushLastFile: 'uploader/PUSH_LAST_FILE',
    }),
    ...mapActions({
      popLastFile: 'uploader/popLastFile',
      getLastFile: 'uploader/getLastFile',
    }),

    //进入指定目录
    async goToDir(index) {
      const length = this.path.length;
      for (let i = 0; i < length - index - 1; i++) {
        this.popLastFile();
      }
      if (index !== length - 1) {
        // let currentFile = await this.getLastFile();
        this.getList();
      }
    },

    //返回上一级目录
    returnParentDirectory() {
      this.popLastFile().then(
        file => {
          if (file) {
            this.getList();
          }
        }
      )
    },
    async returnHome() {
      let currentFile = await this.getLastFile();
      if (currentFile.fileId > 0) {
        this.clearPath();
        await this.getList();
      }
    },
    openDirectory(row, column, event) {
      if (column.property === "fullFileName") {
        if (row.isDir) {//双击目录名，打开目录
          this.pushLastFile(row)
          this.getList()
        } else {
          //双击文件名，预览文件
        }
      }
    },
    /** 查询文件列表 */
    async getList() {
      this.loading = true;
      let currentFile = await this.getLastFile();
      this.queryParams.parentId = currentFile.fileId
      listFiles(this.queryParams).then(response => {
        this.filesList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },

    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.fileId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },

    /** 删除按钮操作 */
    handleDelete(row) {
      const fileIds = row.fileId || this.ids;
      this.$modal.confirm('是否确认删除文件编号为"' + fileIds + '"的数据项？').then(function () {
        return delFiles(fileIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('netdisc/files/export', {
        ...this.queryParams
      }, `files_${new Date().getTime()}.xlsx`)
    }
  }
}
;
</script>
<style scoped lang="scss">

</style>
