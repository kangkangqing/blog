<template>
  <div class="dashboard">
    <!-- 统计卡片 -->
    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-icon blog">
          <el-icon><Document /></el-icon>
        </div>
        <div class="stat-info">
          <div class="stat-number">{{ stats.totalPosts }}</div>
          <div class="stat-label">文章总数</div>
        </div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon user">
          <el-icon><User /></el-icon>
        </div>
        <div class="stat-info">
          <div class="stat-number">{{ stats.totalUsers }}</div>
          <div class="stat-label">用户总数</div>
        </div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon comment">
          <el-icon><ChatLineSquare /></el-icon>
        </div>
        <div class="stat-info">
          <div class="stat-number">{{ stats.totalComments }}</div>
          <div class="stat-label">评论总数</div>
        </div>
      </div>
      
      <div class="stat-card">
        <div class="stat-icon view">
          <el-icon><View /></el-icon>
        </div>
        <div class="stat-info">
          <div class="stat-number">{{ stats.totalViews }}</div>
          <div class="stat-label">总访问量</div>
        </div>
      </div>
    </div>
    
    <!-- 图表区域 -->
    <div class="charts-grid">
      <!-- 访问量趋势图 -->
      <div class="chart-card">
        <div class="card-header">
          <h3>访问量趋势</h3>
        </div>
        <div class="chart-content">
          <div class="chart-placeholder">
            📊 访问量趋势图（需要集成图表库）
          </div>
        </div>
      </div>
      
      <!-- 文章分类统计 -->
      <div class="chart-card">
        <div class="card-header">
          <h3>文章分类统计</h3>
        </div>
        <div class="chart-content">
          <div class="category-stats">
            <div v-for="category in categoryStats" :key="category.id" class="category-item">
              <span class="category-name">{{ category.name }}</span>
              <span class="category-count">{{ category.count }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 最新动态 -->
    <div class="activity-section">
      <div class="section-header">
        <h3>最新动态</h3>
      </div>
      
      <div class="activity-grid">
        <!-- 最新文章 -->
        <div class="activity-card">
          <h4>最新文章</h4>
          <ul class="activity-list">
            <li v-for="post in recentPosts" :key="post.id" class="activity-item">
              <div class="activity-content">
                <div class="activity-title">{{ post.title }}</div>
                <div class="activity-time">{{ formatDate(post.createTime) }}</div>
              </div>
            </li>
          </ul>
        </div>
        
        <!-- 最新评论 -->
        <div class="activity-card">
          <h4>最新评论</h4>
          <ul class="activity-list">
            <li v-for="comment in recentComments" :key="comment.id" class="activity-item">
              <div class="activity-content">
                <div class="activity-title">{{ comment.content }}</div>
                <div class="activity-meta">
                  <span>{{ comment.authorName }}</span>
                  <span class="activity-time">{{ formatDate(comment.createTime) }}</span>
                </div>
              </div>
            </li>
          </ul>
        </div>
        
        <!-- 系统信息 -->
        <div class="activity-card">
          <h4>系统信息</h4>
          <div class="system-info">
            <div class="info-item">
              <span class="info-label">系统版本：</span>
              <span class="info-value">Blog System v1.0.0</span>
            </div>
            <div class="info-item">
              <span class="info-label">运行时间：</span>
              <span class="info-value">{{ systemInfo.uptime }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">数据库：</span>
              <span class="info-value">MySQL 8.0</span>
            </div>
            <div class="info-item">
              <span class="info-label">缓存：</span>
              <span class="info-value">Redis</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { Document, User, ChatLineSquare, View } from '@element-plus/icons-vue'

// 统计数据
const stats = ref({
  totalPosts: 0,
  totalUsers: 0,
  totalComments: 0,
  totalViews: 0
})

// 分类统计
const categoryStats = ref([])

// 最新文章
const recentPosts = ref([])

// 最新评论
const recentComments = ref([])

// 系统信息
const systemInfo = ref({
  uptime: '15 天 8 小时'
})

// 格式化日期
const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('zh-CN')
}

// 获取仪表盘数据
const getDashboardData = async () => {
  try {
    // TODO: 调用API获取真实数据
    
    // 模拟数据
    stats.value = {
      totalPosts: 128,
      totalUsers: 45,
      totalComments: 367,
      totalViews: 15672
    }
    
    categoryStats.value = [
      { id: 1, name: 'Vue.js', count: 25 },
      { id: 2, name: 'Spring Boot', count: 18 },
      { id: 3, name: 'JavaScript', count: 32 },
      { id: 4, name: 'Java', count: 28 }
    ]
    
    recentPosts.value = [
      {
        id: 1,
        title: 'Vue 3 Composition API 深度解析',
        createTime: '2024-01-15T10:30:00'
      },
      {
        id: 2,
        title: 'Spring Boot 最佳实践指南',
        createTime: '2024-01-10T14:20:00'
      },
      {
        id: 3,
        title: 'TypeScript 类型系统详解',
        createTime: '2024-01-08T16:45:00'
      }
    ]
    
    recentComments.value = [
      {
        id: 1,
        content: '写得很好，学到了很多！',
        authorName: '张三',
        createTime: '2024-01-16T09:00:00'
      },
      {
        id: 2,
        content: '期待更多关于Vue的文章',
        authorName: '李四',
        createTime: '2024-01-15T18:30:00'
      }
    ]
  } catch (error) {
    console.error('获取仪表盘数据失败:', error)
  }
}

onMounted(() => {
  getDashboardData()
})
</script>

<style scoped>
.dashboard {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
}

.stat-card {
  background: white;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
  gap: 16px;
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  color: white;
}

.stat-icon.blog {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.stat-icon.user {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.stat-icon.comment {
  background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}

.stat-icon.view {
  background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
}

.stat-info {
  flex: 1;
}

.stat-number {
  font-size: 28px;
  font-weight: bold;
  color: #303133;
  line-height: 1;
  margin-bottom: 4px;
}

.stat-label {
  font-size: 14px;
  color: #909399;
}

.charts-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 20px;
}

.chart-card {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.card-header {
  padding: 20px 24px 0;
  border-bottom: 1px solid #f0f0f0;
}

.card-header h3 {
  margin: 0 0 16px 0;
  font-size: 16px;
  color: #303133;
}

.chart-content {
  padding: 20px 24px;
}

.chart-placeholder {
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f8f9fa;
  border-radius: 8px;
  color: #909399;
  font-size: 14px;
}

.category-stats {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.category-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid #f0f0f0;
}

.category-name {
  font-size: 14px;
  color: #303133;
}

.category-count {
  font-size: 14px;
  font-weight: 500;
  color: #409eff;
}

.activity-section {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.section-header {
  padding: 20px 24px;
  border-bottom: 1px solid #f0f0f0;
}

.section-header h3 {
  margin: 0;
  font-size: 16px;
  color: #303133;
}

.activity-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
  padding: 20px 24px;
}

.activity-card h4 {
  margin: 0 0 16px 0;
  font-size: 14px;
  color: #606266;
  font-weight: 500;
}

.activity-list {
  list-style: none;
  margin: 0;
  padding: 0;
}

.activity-item {
  padding: 12px 0;
  border-bottom: 1px solid #f0f0f0;
}

.activity-item:last-child {
  border-bottom: none;
}

.activity-content {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.activity-title {
  font-size: 14px;
  color: #303133;
  line-height: 1.4;
}

.activity-time {
  font-size: 12px;
  color: #909399;
}

.activity-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 12px;
  color: #909399;
}

.system-info {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.info-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 14px;
}

.info-label {
  color: #606266;
}

.info-value {
  color: #303133;
  font-weight: 500;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .charts-grid {
    grid-template-columns: 1fr;
  }
  
  .activity-grid {
    grid-template-columns: 1fr;
  }
  
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 480px) {
  .stats-grid {
    grid-template-columns: 1fr;
  }
}
</style>
