<template>
  <div class="timeline-page">
    <div class="page-header">
      <h1>文章归档</h1>
      <p>按时间顺序浏览所有文章</p>
    </div>
    
    <div class="timeline-container">
      <div v-for="year in timelineData" :key="year.year" class="year-section">
        <div class="year-header">
          <h2>{{ year.year }}</h2>
          <span class="post-count">{{ year.posts.length }} 篇文章</span>
        </div>
        
        <div class="posts-list">
          <div
            v-for="post in year.posts"
            :key="post.id"
            class="post-item"
            @click="viewPost(post.id)"
          >
            <div class="post-date">{{ formatDate(post.createTime) }}</div>
            <div class="post-info">
              <h3 class="post-title">{{ post.title }}</h3>
              <div class="post-meta">
                <span class="category">{{ post.categoryName }}</span>
                <span class="views">{{ post.viewCount }} 阅读</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const timelineData = ref([
  {
    year: 2024,
    posts: [
      {
        id: 1,
        title: 'Vue 3 Composition API 深度解析',
        categoryName: 'Vue.js',
        createTime: '2024-01-15T10:30:00',
        viewCount: 1250
      },
      {
        id: 2,
        title: 'Spring Boot 最佳实践指南',
        categoryName: 'Spring Boot',
        createTime: '2024-01-10T14:20:00',
        viewCount: 980
      }
    ]
  },
  {
    year: 2023,
    posts: [
      {
        id: 3,
        title: 'TypeScript 类型系统详解',
        categoryName: 'TypeScript',
        createTime: '2023-12-20T16:45:00',
        viewCount: 856
      }
    ]
  }
])

const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('zh-CN', {
    month: '2-digit',
    day: '2-digit'
  })
}

const viewPost = (postId: number) => {
  router.push(`/blog/${postId}`)
}

onMounted(() => {
  // TODO: 从API获取归档数据
})
</script>

<style scoped>
.page-header {
  text-align: center;
  margin-bottom: 40px;
  padding: 40px 0;
  background: white;
  border-radius: 8px;
}

.page-header h1 {
  margin: 0 0 10px 0;
  color: #303133;
  font-size: 32px;
}

.page-header p {
  margin: 0;
  color: #909399;
  font-size: 16px;
}

.timeline-container {
  background: white;
  border-radius: 8px;
  padding: 30px;
}

.year-section {
  margin-bottom: 40px;
}

.year-section:last-child {
  margin-bottom: 0;
}

.year-header {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 2px solid #409eff;
}

.year-header h2 {
  margin: 0;
  color: #409eff;
  font-size: 24px;
}

.post-count {
  color: #909399;
  font-size: 14px;
}

.posts-list {
  position: relative;
  padding-left: 20px;
}

.posts-list::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 2px;
  background: #e4e7ed;
}

.post-item {
  position: relative;
  display: flex;
  gap: 20px;
  padding: 15px 0;
  cursor: pointer;
  transition: all 0.3s;
}

.post-item::before {
  content: '';
  position: absolute;
  left: -9px;
  top: 20px;
  width: 16px;
  height: 16px;
  background: #409eff;
  border: 3px solid white;
  border-radius: 50%;
  box-shadow: 0 0 0 2px #e4e7ed;
}

.post-item:hover {
  background: #f8f9fa;
  margin: 0 -15px;
  padding-left: 15px;
  padding-right: 15px;
  border-radius: 8px;
}

.post-date {
  flex-shrink: 0;
  width: 80px;
  color: #909399;
  font-size: 14px;
  font-weight: 500;
}

.post-info {
  flex: 1;
}

.post-title {
  margin: 0 0 8px 0;
  color: #303133;
  font-size: 18px;
  font-weight: 600;
  transition: color 0.3s;
}

.post-item:hover .post-title {
  color: #409eff;
}

.post-meta {
  display: flex;
  gap: 15px;
  font-size: 14px;
  color: #909399;
}

.category {
  color: #409eff;
  font-weight: 500;
}

@media (max-width: 768px) {
  .timeline-container {
    padding: 20px;
  }
  
  .post-item {
    flex-direction: column;
    gap: 8px;
  }
  
  .post-date {
    width: auto;
  }
  
  .year-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }
}
</style>
