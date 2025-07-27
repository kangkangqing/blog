<template>
  <div class="tag-page">
    <div class="page-header">
      <h1>标签云</h1>
      <p>按标签浏览文章</p>
    </div>
    
    <div class="tag-cloud">
      <span
        v-for="tag in tags"
        :key="tag.id"
        class="tag-item"
        :class="getTagClass(tag.postCount)"
        @click="viewTag(tag.id)"
      >
        {{ tag.name }} ({{ tag.postCount }})
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const tags = ref([
  { id: 1, name: 'Vue3', postCount: 8 },
  { id: 2, name: 'JavaScript', postCount: 12 },
  { id: 3, name: 'Spring Boot', postCount: 6 },
  { id: 4, name: 'Java', postCount: 10 },
  { id: 5, name: 'TypeScript', postCount: 5 },
  { id: 6, name: 'MySQL', postCount: 4 },
  { id: 7, name: 'Redis', postCount: 3 }
])

const viewTag = (tagId: number) => {
  router.push(`/tag/${tagId}`)
}

const getTagClass = (count: number) => {
  if (count > 10) return 'tag-large'
  if (count > 5) return 'tag-medium'
  return 'tag-small'
}

onMounted(() => {
  // TODO: 从API获取标签数据
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

.tag-cloud {
  background: white;
  border-radius: 8px;
  padding: 30px;
  text-align: center;
}

.tag-item {
  display: inline-block;
  margin: 8px;
  padding: 8px 16px;
  border-radius: 20px;
  cursor: pointer;
  transition: all 0.3s;
  border: 1px solid #e1f3ff;
}

.tag-small {
  font-size: 14px;
  background: #f0f9ff;
  color: #409eff;
}

.tag-medium {
  font-size: 16px;
  background: #e1f3ff;
  color: #409eff;
}

.tag-large {
  font-size: 18px;
  background: #409eff;
  color: white;
}

.tag-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
}
</style>
