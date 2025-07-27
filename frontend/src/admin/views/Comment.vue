<template>
  <div class="admin-comment">
    <div class="page-header">
      <h2>评论管理</h2>
    </div>
    
    <div class="table-section">
      <el-table :data="commentList" style="width: 100%" v-loading="loading">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="content" label="评论内容" min-width="200" show-overflow-tooltip />
        <el-table-column prop="authorName" label="评论者" width="120" />
        <el-table-column prop="postTitle" label="文章标题" width="200" show-overflow-tooltip />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'warning'">
              {{ row.status === 1 ? '已审核' : '待审核' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="评论时间" width="180">
          <template #default="{ row }">
            {{ formatDate(row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180">
          <template #default="{ row }">
            <el-button 
              type="text" 
              size="small" 
              @click="handleApprove(row)"
              v-if="row.status === 0"
            >
              审核通过
            </el-button>
            <el-button type="text" size="small" @click="handleView(row)">查看</el-button>
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

const loading = ref(false)
const commentList = ref([
  {
    id: 1,
    content: '写得很好，学到了很多！',
    authorName: '张三',
    postTitle: 'Vue 3 Composition API 深度解析',
    status: 1,
    createTime: '2024-01-16T09:00:00'
  },
  {
    id: 2,
    content: '期待更多关于Vue的文章',
    authorName: '李四',
    postTitle: 'Vue 3 Composition API 深度解析',
    status: 0,
    createTime: '2024-01-15T18:30:00'
  }
])

const formatDate = (dateString: string) => {
  return new Date(dateString).toLocaleString('zh-CN')
}

const handleApprove = (row: any) => {
  row.status = 1
  ElMessage.success('审核通过')
}

const handleView = (row: any) => {
  ElMessage.info(`查看评论：${row.content}`)
}

const handleDelete = (row: any) => {
  ElMessage.info(`删除评论：${row.content}`)
}

onMounted(() => {
  // TODO: 获取评论列表
})
</script>

<style scoped>
.admin-comment {
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
