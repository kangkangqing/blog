<template>
  <div class="admin-blog">
    <div class="page-header">
      <h2>博客管理</h2>
      <el-button type="primary" @click="handleAdd">
        <el-icon><Plus /></el-icon>
        新增文章
      </el-button>
    </div>
    
    <!-- 搜索筛选 -->
    <div class="filter-section">
      <el-form :model="searchForm" inline>
        <el-form-item label="标题">
          <el-input v-model="searchForm.title" placeholder="请输入文章标题" clearable />
        </el-form-item>
        <el-form-item label="分类">
          <el-select v-model="searchForm.categoryId" placeholder="请选择分类" clearable>
            <el-option label="全部" value="" />
            <el-option label="Vue.js" value="1" />
            <el-option label="Spring Boot" value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="searchForm.status" placeholder="请选择状态" clearable>
            <el-option label="全部" value="" />
            <el-option label="已发布" value="1" />
            <el-option label="草稿" value="0" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
    
    <!-- 文章列表 -->
    <div class="table-section">
      <el-table :data="blogList" style="width: 100%" v-loading="loading">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="title" label="标题" min-width="200" show-overflow-tooltip />
        <el-table-column prop="categoryName" label="分类" width="120" />
        <el-table-column prop="authorName" label="作者" width="120" />
        <el-table-column prop="viewCount" label="阅读量" width="100" />
        <el-table-column prop="likeCount" label="点赞数" width="100" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'info'">
              {{ row.status === 1 ? '已发布' : '草稿' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="180">
          <template #default="{ row }">
            {{ formatDate(row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button type="text" size="small" @click="handleEdit(row)">编辑</el-button>
            <el-button type="text" size="small" @click="handleView(row)">查看</el-button>
            <el-button 
              type="text" 
              size="small" 
              @click="handleToggleStatus(row)"
              :class="row.status === 1 ? 'text-warning' : 'text-success'"
            >
              {{ row.status === 1 ? '下线' : '发布' }}
            </el-button>
            <el-button type="text" size="small" class="text-danger" @click="handleDelete(row)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      
      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          :current-page="pagination.page"
          :page-size="pagination.size"
          :page-sizes="[10, 20, 50, 100]"
          :total="pagination.total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'

// 加载状态
const loading = ref(false)

// 搜索表单
const searchForm = ref({
  title: '',
  categoryId: '',
  status: ''
})

// 分页信息
const pagination = ref({
  page: 1,
  size: 10,
  total: 0
})

// 博客列表
const blogList = ref([])

// 获取博客列表
const getBlogList = async () => {
  loading.value = true
  try {
    // TODO: 调用API获取博客列表
    
    // 模拟数据
    const mockData = {
      data: [
        {
          id: 1,
          title: 'Vue 3 Composition API 深度解析',
          categoryName: 'Vue.js',
          authorName: '管理员',
          viewCount: 1250,
          likeCount: 45,
          status: 1,
          createTime: '2024-01-15T10:30:00'
        },
        {
          id: 2,
          title: 'Spring Boot 最佳实践指南',
          categoryName: 'Spring Boot',
          authorName: '管理员',
          viewCount: 980,
          likeCount: 38,
          status: 1,
          createTime: '2024-01-10T14:20:00'
        },
        {
          id: 3,
          title: 'TypeScript 进阶教程（草稿）',
          categoryName: 'TypeScript',
          authorName: '管理员',
          viewCount: 0,
          likeCount: 0,
          status: 0,
          createTime: '2024-01-08T16:45:00'
        }
      ],
      total: 3
    }
    
    blogList.value = mockData.data
    pagination.value.total = mockData.total
  } catch (error) {
    ElMessage.error('获取博客列表失败')
    console.error(error)
  } finally {
    loading.value = false
  }
}

// 格式化日期
const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleString('zh-CN')
}

// 搜索
const handleSearch = () => {
  pagination.value.page = 1
  getBlogList()
}

// 重置搜索
const handleReset = () => {
  searchForm.value = {
    title: '',
    categoryId: '',
    status: ''
  }
  pagination.value.page = 1
  getBlogList()
}

// 新增文章
const handleAdd = () => {
  ElMessage.info('新增文章功能开发中...')
}

// 编辑文章
const handleEdit = (row: any) => {
  ElMessage.info(`编辑文章：${row.title}`)
}

// 查看文章
const handleView = (row: any) => {
  window.open(`/blog/${row.id}`, '_blank')
}

// 切换文章状态
const handleToggleStatus = async (row: any) => {
  const action = row.status === 1 ? '下线' : '发布'
  try {
    await ElMessageBox.confirm(`确定要${action}这篇文章吗？`, '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    // TODO: 调用API切换状态
    row.status = row.status === 1 ? 0 : 1
    ElMessage.success(`${action}成功`)
  } catch {
    // 用户取消
  }
}

// 删除文章
const handleDelete = async (row: any) => {
  try {
    await ElMessageBox.confirm('确定要删除这篇文章吗？删除后无法恢复！', '危险操作', {
      confirmButtonText: '确定删除',
      cancelButtonText: '取消',
      type: 'error'
    })
    
    // TODO: 调用API删除文章
    const index = blogList.value.findIndex((item: any) => item.id === row.id)
    if (index > -1) {
      blogList.value.splice(index, 1)
      pagination.value.total--
    }
    ElMessage.success('删除成功')
  } catch {
    // 用户取消
  }
}

// 分页大小改变
const handleSizeChange = () => {
  getBlogList()
}

// 页码改变
const handleCurrentChange = () => {
  getBlogList()
}

onMounted(() => {
  getBlogList()
})
</script>

<style scoped>
.admin-blog {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: white;
  padding: 20px 24px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.page-header h2 {
  margin: 0;
  color: #303133;
  font-size: 20px;
}

.filter-section {
  background: white;
  padding: 20px 24px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.table-section {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.pagination {
  padding: 20px 24px;
  display: flex;
  justify-content: flex-end;
  border-top: 1px solid #f0f0f0;
}

.text-warning {
  color: #e6a23c !important;
}

.text-success {
  color: #67c23a !important;
}

.text-danger {
  color: #f56c6c !important;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .page-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .filter-section .el-form {
    flex-direction: column;
  }
  
  .filter-section .el-form-item {
    margin-right: 0;
  }
}
</style>
