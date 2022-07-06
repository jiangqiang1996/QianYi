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
    <avue-crud :data="filteredData" v-loadmore="handelLoadmore" :option="option"
               :data-size="tableData.length"></avue-crud>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
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
          @click="handleUpdate"
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
    <el-table v-loading="loading" :data="filesList" @selection-change="handleSelectionChange"
              @row-dblclick="openDirectory">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="文件名" align="center" prop="fullFileName"/>
      <el-table-column label="上传时间" align="center" prop="createTime"/>
      <el-table-column label="修改时间" align="center" prop="updateTime"/>
      <el-table-column label="文件大小" align="center" prop="size"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['netdisc:files:edit']"
          >分享
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['netdisc:files:edit']"
          >下载
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['netdisc:files:edit']"
          >删除
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['netdisc:files:edit']"
          >重命名
          </el-button>
        </template>
      </el-table-column>
    </el-table>

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
      tableData: [],
      option: {
        height: 300,
        expand: true,
        selection: true,
        selectionFixed: false,
        expandFixed: false,
        menuFixed: false,
        column: [{
          label: '姓名',
          prop: 'name',
          width: 200,
        }, {
          label: '年龄',
          prop: 'sex'
        }]
      },
      currentStartIndex: 0,
      currentEndIndex: 20,

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
  directives: {
    loadmore: {
      componentUpdated: function (el, binding, vnode, oldVnode) {
        // 设置默认溢出显示数量
        var spillDataNum = 20;

        // 设置隐藏函数
        var timeout = false;
        let setRowDisableNone = function (topNum, showRowNum, binding) {
          if (timeout) {
            clearTimeout(timeout);
          }
          timeout = setTimeout(() => {
            binding.value.call(null, topNum, topNum + showRowNum + spillDataNum);
          });
        };
        setTimeout(() => {
          const dataSize = vnode.data.attrs['data-size'];
          const oldDataSize = oldVnode.data.attrs['data-size'];
          if (dataSize === oldDataSize) return;
          const selectWrap = el.querySelector('.el-table__body-wrapper');
          const selectTbody = selectWrap.querySelector('table tbody');
          const selectRow = selectWrap.querySelector('table tr');
          if (!selectRow) {
            return;
          }
          const rowHeight = selectRow.clientHeight;
          let showRowNum = Math.round(selectWrap.clientHeight / rowHeight);

          const createElementTR = document.createElement('tr');
          let createElementTRHeight = (dataSize - showRowNum - spillDataNum) * rowHeight;
          createElementTR.setAttribute('style', `height: ${createElementTRHeight}px;`);
          selectTbody.append(createElementTR);

          // 监听滚动后事件
          selectWrap.addEventListener('scroll', function () {
            let topPx = this.scrollTop - spillDataNum * rowHeight;
            let topNum = Math.round(topPx / rowHeight);
            let minTopNum = dataSize - spillDataNum - showRowNum;
            if (topNum > minTopNum) {
              topNum = minTopNum;
            }
            if (topNum < 0) {
              topNum = 0;
              topPx = 0;
            }
            selectTbody.setAttribute('style', `transform: translateY(${topPx}px)`);
            createElementTR.setAttribute('style', `height: ${createElementTRHeight - topPx > 0 ? createElementTRHeight - topPx : 0}px;`);
            setRowDisableNone(topNum, showRowNum, binding);
          })
        });
      }
    }
  },
  created() {
    this.getList();
    this.getTableData();
  },
  mounted() {
    this.uploader.assignBrowse(this.$refs.selectFile, false)
    this.uploader.assignBrowse(this.$refs.selectDirectory, true)
  },
  computed: {
    ...mapGetters(["globalUploader", "uploader", "path"]),
    filteredData() {
      let list = this.tableData.filter((item, index) => {
        if (index < this.currentStartIndex) {
          return false;
        } else if (index > this.currentEndIndex) {
          return false;
        } else {
          return true;
        }
      });
      return list
    }
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
    handelLoadmore(currentStartIndex, currentEndIndex) {
      this.currentStartIndex = currentStartIndex;
      this.currentEndIndex = currentEndIndex;
    },
    getTableData() {
      let cont = 0;
      let tableData = [];
      while (cont < 10000) {
        cont = cont + 1;
        let object = {
          name: '王小虎' + cont,
          sex: cont
        }
        tableData.push(object);
      }
      setTimeout(() => {
        this.tableData = tableData;
      }, 0);
    },

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
    returnParentDirectory() {//返回上一级目录
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
        this.getList();
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
