<template>
  <div class="admin-category">
    <div class="page-header">
      <h2>分类管理</h2>
      <el-button type="primary" @click="handleAdd">
        <el-icon><Plus /></el-icon>
        新增分类
      </el-button>
    </div>
    
    <div class="table-section">
      <el-table :data="categoryList" style="width: 100%" v-loading="loading">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="name" label="分类名称" />
        <el-table-column prop="description" label="描述" />
        <el-table-column prop="postCount" label="文章数" width="100" />
        <el-table-column prop="createTime" label="创建时间" width="180">
          <template #default="{ row }">
            {{ formatDate(row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150">
          <template #default="{ row }">
            <el-button type="text" size="small" @click="handleEdit(row)">编辑</el-button>
            <el-button type="text" size="small" class="text-danger" @click="handleDelete(row)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'

const loading = ref(false)
const categoryList = ref([
  {
    id: 1,
    name: 'Vue.js',
    description: 'Vue.js 相关技术文章',
    postCount: 12,
    createTime: '2024-01-01T10:00:00'
  },
  {
    id: 2,
    name: 'Spring Boot',
    description: 'Spring Boot 开发实践',
    postCount: 8,
    createTime: '2024-01-02T10:00:00'
  }
])

const formatDate = (dateString: string) => {
  return new Date(dateString).toLocaleString('zh-CN')
}

const handleAdd = () => {
  ElMessage.info('新增分类功能开发中...')
}

const handleEdit = (row: any) => {
  ElMessage.info(`编辑分类：${row.name}`)
}

const handleDelete = (row: any) => {
  ElMessage.info(`删除分类：${row.name}`)
}

onMounted(() => {
  // TODO: 获取分类列表
})
</script>

<style scoped>
.admin-category {
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

.table-section {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.text-danger {
  color: #f56c6c !important;
}
</style>
