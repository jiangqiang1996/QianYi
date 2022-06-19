<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="文章标题" prop="storageTitle">
        <el-input
          v-model="queryParams.storageTitle"
          placeholder="请输入文章标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文章固定链接" prop="articleUrl">
        <el-input
          v-model="queryParams.articleUrl"
          placeholder="请输入文章固定链接"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文章分类" prop="categoryId">
        <el-input
          v-model="queryParams.categoryId"
          placeholder="请输入文章分类"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="文章标签id组成的字符串" prop="tagIds">
        <el-input
          v-model="queryParams.tagIds"
          placeholder="请输入文章标签id组成的字符串"
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
          @click="handleAdd"
          v-hasPermi="['web:articles:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['web:articles:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['web:articles:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['web:articles:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="articlesList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="文章id" align="center" prop="articleId" />
      <el-table-column label="标题" align="center" prop="storageTitle" />
<!--      <el-table-column label="内容" align="center" prop="originalContent" />-->
<!--      <el-table-column label="文章html内容" align="center" prop="htmlContent" />-->
<!--      <el-table-column label="文章固定链接" align="center" prop="articleUrl" />-->
      <el-table-column label="文章分类" align="center" prop="categoryId" />
<!--      <el-table-column label="文章标签id组成的字符串" align="center" prop="tagIds" />-->
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['web:articles:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['web:articles:remove']"
          >删除</el-button>
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

    <!-- 添加或修改文章新增对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="80%" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="标题" prop="storageTitle">
          <el-input v-model="form.storageTitle" placeholder="请输入文章标题" />
        </el-form-item>
        <el-form-item label="内容">
          <editor v-model="form.originalContent" :min-height="192"/>
        </el-form-item>
<!--        <el-form-item label="文章html内容">-->
<!--          <editor v-model="form.htmlContent" :min-height="192"/>-->
<!--        </el-form-item>-->
        <el-form-item label="文章固定链接" prop="articleUrl">
          <el-input v-model="form.articleUrl" placeholder="请输入文章固定访问地址" />
        </el-form-item>
        <el-form-item label="文章分类" prop="categoryId">
          <el-input v-model="form.categoryId" placeholder="请输入文章分类" />
        </el-form-item>
        <el-form-item label="文章标签id组成的字符串" prop="tagIds">
          <el-input v-model="form.tagIds" placeholder="请输入文章标签" />
        </el-form-item>
<!--        <el-form-item label="删除标志" prop="delFlag">-->
<!--          <el-input v-model="form.delFlag" placeholder="请输入删除标志" />-->
<!--        </el-form-item>-->
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listArticles, getArticles, delArticles, addArticles, updateArticles } from "@/api/web/articles";

export default {
  name: "Articles",
  data() {
    return {
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
      // 文章新增表格数据
      articlesList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        storageTitle: null,
        originalContent: null,
        htmlContent: null,
        articleUrl: null,
        categoryId: null,
        tagIds: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        storageTitle: [
          { required: true, message: "文章标题不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询文章新增列表 */
    getList() {
      this.loading = true;
      listArticles(this.queryParams).then(response => {
        this.articlesList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        articleId: null,
        storageTitle: null,
        originalContent: null,
        htmlContent: null,
        articleUrl: null,
        categoryId: null,
        tagIds: null,
        delFlag: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null
      };
      this.resetForm("form");
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
      this.ids = selection.map(item => item.articleId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加文章新增";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const articleId = row.articleId || this.ids
      getArticles(articleId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改文章新增";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.articleId != null) {
            updateArticles(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addArticles(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const articleIds = row.articleId || this.ids;
      this.$modal.confirm('是否确认删除文章新增编号为"' + articleIds + '"的数据项？').then(function() {
        return delArticles(articleIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('web/articles/export', {
        ...this.queryParams
      }, `articles_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
