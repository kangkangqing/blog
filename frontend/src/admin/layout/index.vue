<template>
  <div class="admin-layout">
    <el-container>
      <!-- 侧边栏 -->
      <el-aside :width="isCollapse ? '64px' : '200px'" class="sidebar">
        <div class="logo">
          <div v-if="!isCollapse" class="logo-placeholder">📝</div>
          <span v-if="!isCollapse" class="logo-text">博客管理</span>
          <span v-else class="logo-mini">B</span>
        </div>
        
        <el-menu
          :default-active="$route.path"
          :collapse="isCollapse"
          :unique-opened="true"
          router
          background-color="#304156"
          text-color="#bfcbd9"
          active-text-color="#409eff"
        >
          <el-menu-item index="/admin/dashboard">
            <el-icon><Odometer /></el-icon>
            <template #title>仪表盘</template>
          </el-menu-item>
          
          <el-menu-item index="/admin/blog">
            <el-icon><Document /></el-icon>
            <template #title>博客管理</template>
          </el-menu-item>
          
          <el-menu-item index="/admin/category">
            <el-icon><Folder /></el-icon>
            <template #title>分类管理</template>
          </el-menu-item>
          
          <el-menu-item index="/admin/tag">
            <el-icon><Collection /></el-icon>
            <template #title>标签管理</template>
          </el-menu-item>
          
          <el-menu-item index="/admin/user">
            <el-icon><User /></el-icon>
            <template #title>用户管理</template>
          </el-menu-item>
          
          <el-menu-item index="/admin/comment">
            <el-icon><ChatLineSquare /></el-icon>
            <template #title>评论管理</template>
          </el-menu-item>
          
          <el-menu-item index="/admin/system">
            <el-icon><Setting /></el-icon>
            <template #title>系统设置</template>
          </el-menu-item>
        </el-menu>
      </el-aside>
      
      <!-- 主要内容区域 -->
      <el-container>
        <!-- 顶部导航栏 -->
        <el-header class="header">
          <div class="header-left">
            <el-button
              type="text"
              size="large"
              @click="toggleCollapse"
              class="collapse-btn"
            >
              <el-icon><Expand v-if="isCollapse" /><Fold v-else /></el-icon>
            </el-button>
            
            <!-- 面包屑导航 -->
            <el-breadcrumb separator="/" class="breadcrumb">
              <el-breadcrumb-item :to="{ path: '/admin' }">管理后台</el-breadcrumb-item>
              <el-breadcrumb-item>{{ currentPageTitle }}</el-breadcrumb-item>
            </el-breadcrumb>
          </div>
          
          <div class="header-right">
            <!-- 全屏按钮 -->
            <el-button type="text" @click="toggleFullscreen" class="header-btn">
              <el-icon><FullScreen /></el-icon>
            </el-button>
            
            <!-- 用户信息下拉菜单 -->
            <el-dropdown @command="handleCommand" class="user-dropdown">
              <span class="user-info">
                <el-avatar :size="32">
                  <el-icon><User /></el-icon>
                </el-avatar>
                <span class="username">管理员</span>
                <el-icon><ArrowDown /></el-icon>
              </span>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item command="profile">个人资料</el-dropdown-item>
                  <el-dropdown-item command="password">修改密码</el-dropdown-item>
                  <el-dropdown-item command="logout" divided>退出登录</el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
          </div>
        </el-header>
        
        <!-- 主要内容 -->
        <el-main class="main-content">
          <router-view />
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  Odometer,
  Document,
  Folder,
  Collection,
  User,
  ChatLineSquare,
  Setting,
  Expand,
  Fold,
  FullScreen,
  ArrowDown
} from '@element-plus/icons-vue'

const route = useRoute()
const router = useRouter()

// 侧边栏折叠状态
const isCollapse = ref(false)

// 当前页面标题
const currentPageTitle = computed(() => {
  return route.meta?.title || '管理后台'
})

// 切换侧边栏折叠状态
const toggleCollapse = () => {
  isCollapse.value = !isCollapse.value
}

// 切换全屏
const toggleFullscreen = () => {
  if (!document.fullscreenElement) {
    document.documentElement.requestFullscreen()
  } else {
    document.exitFullscreen()
  }
}

// 处理用户下拉菜单命令
const handleCommand = async (command: string) => {
  switch (command) {
    case 'profile':
      ElMessage.info('个人资料功能开发中...')
      break
    case 'password':
      ElMessage.info('修改密码功能开发中...')
      break
    case 'logout':
      try {
        await ElMessageBox.confirm('确定要退出登录吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        })
        
        // TODO: 清除登录状态
        localStorage.removeItem('admin_token')
        ElMessage.success('退出登录成功')
        router.push('/login')
      } catch {
        // 用户取消退出
      }
      break
  }
}
</script>

<style scoped>
.admin-layout {
  height: 100vh;
}

.el-container {
  height: 100%;
}

.sidebar {
  background-color: #304156;
  transition: width 0.3s;
}

.logo {
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #2b3a47;
  color: white;
  font-size: 16px;
  font-weight: bold;
}

.logo-placeholder {
  font-size: 24px;
  margin-right: 8px;
}

.logo-mini {
  font-size: 20px;
  font-weight: bold;
  color: #409eff;
}

.el-menu {
  border-right: none;
}

.header {
  background-color: #fff;
  border-bottom: 1px solid #e4e7ed;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 20px;
}

.collapse-btn {
  color: #606266;
  font-size: 18px;
}

.breadcrumb {
  font-size: 14px;
}

.header-right {
  display: flex;
  align-items: center;
  gap: 15px;
}

.header-btn {
  color: #606266;
  font-size: 16px;
}

.user-dropdown {
  cursor: pointer;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px;
  border-radius: 4px;
  transition: background-color 0.3s;
}

.user-info:hover {
  background-color: #f5f7fa;
}

.username {
  font-size: 14px;
  color: #303133;
  font-weight: 500;
}

.main-content {
  background-color: #f0f2f5;
  padding: 20px;
  overflow-y: auto;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .sidebar {
    position: fixed;
    z-index: 1000;
    height: 100vh;
  }
  
  .header-left {
    gap: 10px;
  }
  
  .breadcrumb {
    display: none;
  }
  
  .main-content {
    padding: 15px;
  }
}
</style>
