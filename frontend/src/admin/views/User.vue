<template>
  <div class="admin-user">
    <div class="page-header">
      <h2>用户管理</h2>
    </div>
    
    <div class="table-section">
      <el-table :data="userList" style="width: 100%" v-loading="loading">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="username" label="用户名" />
        <el-table-column prop="nickname" label="昵称" />
        <el-table-column prop="email" label="邮箱" />
        <el-table-column prop="role" label="角色" width="100">
          <template #default="{ row }">
            <el-tag :type="row.role === 'admin' ? 'danger' : 'primary'">
              {{ row.role === 'admin' ? '管理员' : '用户' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '正常' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="注册时间" width="180">
          <template #default="{ row }">
            {{ formatDate(row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150">
          <template #default="{ row }">
            <el-button 
              type="text" 
              size="small" 
              @click="handleToggleStatus(row)"
              :class="row.status === 1 ? 'text-warning' : 'text-success'"
            >
              {{ row.status === 1 ? '禁用' : '启用' }}
            </el-button>
            <el-button type="text" size="small" @click="handleEdit(row)">编辑</el-button>
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
const userList = ref([
  {
    id: 1,
    username: 'admin',
    nickname: '管理员',
    email: 'admin@blog.com',
    role: 'admin',
    status: 1,
    createTime: '2024-01-01T10:00:00'
  },
  {
    id: 2,
    username: 'user001',
    nickname: '张三',
    email: 'zhangsan@example.com',
    role: 'user',
    status: 1,
    createTime: '2024-01-05T15:30:00'
  }
])

const formatDate = (dateString: string) => {
  return new Date(dateString).toLocaleString('zh-CN')
}

const handleToggleStatus = (row: any) => {
  const action = row.status === 1 ? '禁用' : '启用'
  row.status = row.status === 1 ? 0 : 1
  ElMessage.success(`${action}用户成功`)
}

const handleEdit = (row: any) => {
  ElMessage.info(`编辑用户：${row.nickname}`)
}

onMounted(() => {
  // TODO: 获取用户列表
})
</script>

<style scoped>
.admin-user {
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

.text-warning {
  color: #e6a23c !important;
}

.text-success {
  color: #67c23a !important;
}
</style>
