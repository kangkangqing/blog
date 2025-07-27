<template>
  <div class="category-detail">
    <div class="page-header">
      <h1>{{ category?.name || '分类详情' }}</h1>
      <p>{{ category?.description }}</p>
      <div class="category-stats">
        共 {{ posts.length }} 篇文章
      </div>
    </div>
    
    <div class="posts-list">
      <div
        v-for="post in posts"
        :key="post.id"
        class="post-card"
        @click="viewPost(post.id)"
      >
        <div class="post-meta">
          <span class="date">{{ formatDate(post.createTime) }}</span>
          <span class="views">{{ post.viewCount }} 阅读</span>
        </div>
        <h3 class="post-title">{{ post.title }}</h3>
        <p class="post-summary">{{ post.summary }}</p>
        <div class="post-tags">
          <el-tag
            v-for="tag in post.tags"
            :key="tag.id"
            size="small"
            effect="plain"
          >
            {{ tag.name }}
          </el-tag>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()

const category = ref(null)
const posts = ref([])

const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('zh-CN')
}

const viewPost = (postId: number) => {
  router.push(`/blog/${postId}`)
}

onMounted(() => {
  // TODO: 根据route.params.id获取分类详情和文章列表
  category.value = {
    id: 1,
    name: 'Vue.js',
    description: 'Vue.js 相关技术文章'
  }
  
  posts.value = [
    {
      id: 1,
      title: 'Vue 3 Composition API 深度解析',
      summary: 'Vue 3 引入了全新的 Composition API...',
      createTime: '2024-01-15T10:30:00',
      viewCount: 1250,
      tags: [{ id: 1, name: 'Vue3' }]
    }
  ]
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
  margin: 0 0 15px 0;
  color: #909399;
  font-size: 16px;
}

.category-stats {
  color: #409eff;
  font-weight: 500;
}

.posts-list {
  display: grid;
  gap: 20px;
}

.post-card {
  background: white;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: all 0.3s;
  cursor: pointer;
}

.post-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.post-meta {
  display: flex;
  gap: 15px;
  margin-bottom: 10px;
  font-size: 14px;
  color: #909399;
}

.post-title {
  margin: 0 0 10px 0;
  font-size: 20px;
  font-weight: 600;
  color: #303133;
}

.post-summary {
  margin: 0 0 15px 0;
  color: #606266;
  line-height: 1.6;
}

.post-tags .el-tag {
  margin-right: 8px;
}
</style>
