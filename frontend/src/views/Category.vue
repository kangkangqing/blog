<template>
  <div class="category-page">
    <div class="page-header">
      <h1>文章分类</h1>
      <p>按分类浏览所有文章</p>
    </div>
    
    <div class="category-grid">
      <div
        v-for="category in categories"
        :key="category.id"
        class="category-card"
        @click="viewCategory(category.id)"
      >
        <div class="category-icon">
          <span>{{ category.icon || '📂' }}</span>
        </div>
        <div class="category-info">
          <h3>{{ category.name }}</h3>
          <p>{{ category.description }}</p>
          <div class="category-stats">
            <span>{{ category.postCount }} 篇文章</span>
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

const categories = ref([
  {
    id: 1,
    name: 'Vue.js',
    description: 'Vue.js 相关技术文章',
    icon: '🔧',
    postCount: 12
  },
  {
    id: 2,
    name: 'Spring Boot',
    description: 'Spring Boot 开发实践',
    icon: '☕',
    postCount: 8
  },
  {
    id: 3,
    name: 'JavaScript',
    description: 'JavaScript 基础与进阶',
    icon: '📜',
    postCount: 15
  }
])

const viewCategory = (categoryId: number) => {
  router.push(`/category/${categoryId}`)
}

onMounted(() => {
  // TODO: 从API获取分类数据
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

.category-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.category-card {
  background: white;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: all 0.3s;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 16px;
}

.category-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.category-icon {
  font-size: 32px;
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f0f9ff;
  border-radius: 12px;
}

.category-info h3 {
  margin: 0 0 8px 0;
  color: #303133;
  font-size: 20px;
}

.category-info p {
  margin: 0 0 12px 0;
  color: #606266;
  font-size: 14px;
}

.category-stats {
  color: #909399;
  font-size: 13px;
}
</style>
