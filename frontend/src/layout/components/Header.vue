<template>
  <header class="header">
    <div class="container">
      <div class="header-content">
        <!-- Logo 和网站名称 -->
        <div class="logo">
          <router-link to="/" class="logo-link">
            <h1>个人博客</h1>
          </router-link>
        </div>
        
        <!-- 导航菜单 -->
        <nav class="navbar">
          <ul class="nav-list">
            <li class="nav-item">
              <router-link to="/home" class="nav-link">首页</router-link>
            </li>
            <li class="nav-item">
              <router-link to="/category" class="nav-link">分类</router-link>
            </li>
            <li class="nav-item">
              <router-link to="/tag" class="nav-link">标签</router-link>
            </li>
            <li class="nav-item">
              <router-link to="/archive" class="nav-link">归档</router-link>
            </li>
            <li class="nav-item">
              <router-link to="/about" class="nav-link">关于</router-link>
            </li>
          </ul>
        </nav>
        
        <!-- 搜索框 -->
        <div class="search-box">
          <el-input
            v-model="searchKeyword"
            placeholder="搜索文章..."
            prefix-icon="Search"
            @keyup.enter="handleSearch"
            clearable
          />
        </div>
        
        <!-- 用户操作区域 -->
        <div class="user-actions">
          <template v-if="!isLoggedIn">
            <el-button type="primary" @click="handleLogin">登录</el-button>
            <el-button @click="handleRegister">注册</el-button>
          </template>
          <template v-else>
            <el-dropdown @command="handleUserCommand">
              <span class="user-info">
                <el-avatar :src="userInfo.avatar" :size="32" />
                <span class="username">{{ userInfo.nickname }}</span>
                <el-icon><ArrowDown /></el-icon>
              </span>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item command="profile">个人资料</el-dropdown-item>
                  <el-dropdown-item command="admin" v-if="userInfo.role === 'admin'">后台管理</el-dropdown-item>
                  <el-dropdown-item command="logout" divided>退出登录</el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
          </template>
        </div>
        
        <!-- 移动端菜单按钮 -->
        <div class="mobile-menu-btn" @click="toggleMobileMenu">
          <el-icon><Menu /></el-icon>
        </div>
      </div>
      
      <!-- 移动端菜单 -->
      <div v-show="showMobileMenu" class="mobile-menu">
        <ul class="mobile-nav-list">
          <li><router-link to="/home" @click="closeMobileMenu">首页</router-link></li>
          <li><router-link to="/category" @click="closeMobileMenu">分类</router-link></li>
          <li><router-link to="/tag" @click="closeMobileMenu">标签</router-link></li>
          <li><router-link to="/archive" @click="closeMobileMenu">归档</router-link></li>
          <li><router-link to="/about" @click="closeMobileMenu">关于</router-link></li>
        </ul>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref, reactive, computed } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowDown, Menu } from '@element-plus/icons-vue'

const router = useRouter()

// 搜索关键词
const searchKeyword = ref('')

// 移动端菜单显示状态
const showMobileMenu = ref(false)

// 用户信息
const userInfo = reactive({
  nickname: '',
  avatar: '',
  role: ''
})

// 登录状态
const isLoggedIn = computed(() => {
  // TODO: 从store或localStorage获取登录状态
  return false
})

// 处理搜索
const handleSearch = () => {
  if (searchKeyword.value.trim()) {
    router.push({
      path: '/search',
      query: { keyword: searchKeyword.value }
    })
  }
}

// 处理登录
const handleLogin = () => {
  router.push('/login')
}

// 处理注册
const handleRegister = () => {
  router.push('/register')
}

// 处理用户下拉菜单命令
const handleUserCommand = (command: string) => {
  switch (command) {
    case 'profile':
      router.push('/profile')
      break
    case 'admin':
      router.push('/admin')
      break
    case 'logout':
      // TODO: 处理退出登录逻辑
      ElMessage.success('退出登录成功')
      break
  }
}

// 切换移动端菜单
const toggleMobileMenu = () => {
  showMobileMenu.value = !showMobileMenu.value
}

// 关闭移动端菜单
const closeMobileMenu = () => {
  showMobileMenu.value = false
}
</script>

<style scoped>
.header {
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 64px;
}

.logo {
  flex-shrink: 0;
}

.logo-link {
  text-decoration: none;
  color: inherit;
}

.logo h1 {
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #409eff;
}

.navbar {
  flex: 1;
  margin: 0 40px;
}

.nav-list {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: 30px;
}

.nav-item {
  position: relative;
}

.nav-link {
  text-decoration: none;
  color: #606266;
  font-weight: 500;
  padding: 8px 0;
  transition: color 0.3s;
}

.nav-link:hover,
.nav-link.router-link-active {
  color: #409eff;
}

.search-box {
  width: 200px;
  margin-right: 20px;
}

.user-actions {
  display: flex;
  align-items: center;
  gap: 10px;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  padding: 8px;
  border-radius: 4px;
  transition: background-color 0.3s;
}

.user-info:hover {
  background-color: #f5f7fa;
}

.username {
  font-weight: 500;
  color: #303133;
}

.mobile-menu-btn {
  display: none;
  cursor: pointer;
  padding: 8px;
  border-radius: 4px;
  transition: background-color 0.3s;
}

.mobile-menu-btn:hover {
  background-color: #f5f7fa;
}

.mobile-menu {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background-color: #fff;
  border-top: 1px solid #e4e7ed;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.mobile-nav-list {
  list-style: none;
  margin: 0;
  padding: 10px 0;
}

.mobile-nav-list li {
  padding: 0 20px;
}

.mobile-nav-list a {
  display: block;
  padding: 12px 0;
  text-decoration: none;
  color: #606266;
  border-bottom: 1px solid #f0f0f0;
  transition: color 0.3s;
}

.mobile-nav-list a:hover,
.mobile-nav-list a.router-link-active {
  color: #409eff;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .navbar {
    display: none;
  }
  
  .search-box {
    display: none;
  }
  
  .mobile-menu-btn {
    display: block;
  }
  
  .header-content {
    height: 56px;
  }
  
  .logo h1 {
    font-size: 20px;
  }
}

@media (max-width: 480px) {
  .container {
    padding: 0 15px;
  }
  
  .user-actions .el-button {
    padding: 8px 12px;
    font-size: 14px;
  }
}
</style>
