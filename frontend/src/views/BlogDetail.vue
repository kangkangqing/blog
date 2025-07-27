<template>
  <div class="blog-detail">
    <div v-if="loading" class="loading">
      <el-skeleton :rows="10" animated />
    </div>
    
    <article v-else-if="post" class="post-article">
      <!-- 文章头部 -->
      <header class="post-header">
        <h1 class="post-title">{{ post.title }}</h1>
        <div class="post-meta">
          <span class="author">作者：{{ post.authorName }}</span>
          <span class="date">发布时间：{{ formatDate(post.createTime) }}</span>
          <span class="category">分类：{{ post.categoryName }}</span>
          <span class="views">阅读量：{{ post.viewCount }}</span>
        </div>
        <div class="post-tags">
          <el-tag
            v-for="tag in post.tags"
            :key="tag.id"
            size="small"
            @click="viewTag(tag.id)"
          >
            {{ tag.name }}
          </el-tag>
        </div>
      </header>
      
      <!-- 文章内容 -->
      <div class="post-content" v-html="post.content"></div>
      
      <!-- 文章底部 -->
      <footer class="post-footer">
        <div class="post-actions">
          <el-button type="primary" @click="toggleLike">
            {{ post.isLiked ? '已点赞' : '点赞' }} ({{ post.likeCount }})
          </el-button>
          <el-button @click="scrollToComments">
            评论 ({{ post.commentCount }})
          </el-button>
        </div>
        
        <!-- 上一篇下一篇 -->
        <div class="post-navigation">
          <div v-if="prevPost" class="nav-item prev" @click="viewPost(prevPost.id)">
            <span class="nav-label">上一篇</span>
            <span class="nav-title">{{ prevPost.title }}</span>
          </div>
          <div v-if="nextPost" class="nav-item next" @click="viewPost(nextPost.id)">
            <span class="nav-label">下一篇</span>
            <span class="nav-title">{{ nextPost.title }}</span>
          </div>
        </div>
      </footer>
    </article>
    
    <!-- 评论区 -->
    <section class="comments-section" ref="commentsRef">
      <h3>评论 ({{ post?.commentCount || 0 }})</h3>
      
      <!-- 评论表单 -->
      <div class="comment-form">
        <el-form :model="commentForm" label-position="top">
          <el-form-item label="昵称">
            <el-input v-model="commentForm.authorName" placeholder="请输入昵称" />
          </el-form-item>
          <el-form-item label="邮箱">
            <el-input v-model="commentForm.email" placeholder="请输入邮箱" />
          </el-form-item>
          <el-form-item label="评论内容">
            <el-input
              v-model="commentForm.content"
              type="textarea"
              :rows="4"
              placeholder="请输入评论内容..."
            />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitComment">发表评论</el-button>
          </el-form-item>
        </el-form>
      </div>
      
      <!-- 评论列表 -->
      <div class="comments-list">
        <div v-for="comment in comments" :key="comment.id" class="comment-item">
          <div class="comment-header">
            <span class="comment-author">{{ comment.authorName }}</span>
            <span class="comment-date">{{ formatDate(comment.createTime) }}</span>
          </div>
          <div class="comment-content">{{ comment.content }}</div>
        </div>
      </div>
    </section>
    
    <div v-if="!loading && !post" class="not-found">
      <h2>文章不存在</h2>
      <el-button type="primary" @click="$router.push('/')">返回首页</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'

const route = useRoute()
const router = useRouter()

const loading = ref(true)
const post = ref(null)
const prevPost = ref(null)
const nextPost = ref(null)
const comments = ref([])
const commentsRef = ref()

const commentForm = ref({
  authorName: '',
  email: '',
  content: ''
})

// 获取文章详情
const getPostDetail = async () => {
  try {
    const postId = route.params.id
    // TODO: 调用API获取文章详情
    
    // 模拟数据
    post.value = {
      id: 1,
      title: 'Vue 3 Composition API 深度解析',
      content: '<p>这是文章内容...</p>',
      authorName: '博主',
      categoryName: 'Vue.js',
      createTime: '2024-01-15T10:30:00',
      viewCount: 1250,
      likeCount: 45,
      commentCount: 12,
      isLiked: false,
      tags: [
        { id: 1, name: 'Vue3' },
        { id: 2, name: 'JavaScript' }
      ]
    }
    
    prevPost.value = {
      id: 2,
      title: '上一篇文章标题'
    }
    
    nextPost.value = {
      id: 3,
      title: '下一篇文章标题'
    }
    
    comments.value = [
      {
        id: 1,
        authorName: '张三',
        content: '写得很好，学到了很多！',
        createTime: '2024-01-16T09:00:00'
      }
    ]
    
    loading.value = false
  } catch (error) {
    console.error('获取文章详情失败:', error)
    loading.value = false
  }
}

// 格式化日期
const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleString('zh-CN')
}

// 查看标签
const viewTag = (tagId: number) => {
  router.push(`/tag/${tagId}`)
}

// 查看文章
const viewPost = (postId: number) => {
  router.push(`/blog/${postId}`)
}

// 切换点赞
const toggleLike = async () => {
  try {
    // TODO: 调用API切换点赞状态
    post.value.isLiked = !post.value.isLiked
    post.value.likeCount += post.value.isLiked ? 1 : -1
    ElMessage.success(post.value.isLiked ? '点赞成功' : '取消点赞')
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

// 滚动到评论区
const scrollToComments = () => {
  nextTick(() => {
    commentsRef.value?.scrollIntoView({ behavior: 'smooth' })
  })
}

// 提交评论
const submitComment = async () => {
  if (!commentForm.value.content.trim()) {
    ElMessage.warning('请输入评论内容')
    return
  }
  
  try {
    // TODO: 调用API提交评论
    const newComment = {
      id: Date.now(),
      authorName: commentForm.value.authorName || '匿名用户',
      content: commentForm.value.content,
      createTime: new Date().toISOString()
    }
    
    comments.value.unshift(newComment)
    post.value.commentCount++
    
    // 清空表单
    commentForm.value.content = ''
    
    ElMessage.success('评论发表成功')
  } catch (error) {
    ElMessage.error('评论发表失败')
  }
}

onMounted(() => {
  getPostDetail()
})
</script>

<style scoped>
.blog-detail {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.loading,
.not-found {
  background: white;
  border-radius: 8px;
  padding: 40px;
  text-align: center;
}

.post-article {
  background: white;
  border-radius: 8px;
  padding: 40px;
  margin-bottom: 30px;
}

.post-header {
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 1px solid #e4e7ed;
}

.post-title {
  margin: 0 0 15px 0;
  color: #303133;
  font-size: 28px;
  font-weight: 700;
  line-height: 1.4;
}

.post-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  margin-bottom: 15px;
  font-size: 14px;
  color: #909399;
}

.post-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.post-tags .el-tag {
  cursor: pointer;
}

.post-content {
  color: #606266;
  line-height: 1.8;
  font-size: 16px;
  margin-bottom: 30px;
}

.post-content :deep(h1),
.post-content :deep(h2),
.post-content :deep(h3) {
  margin-top: 30px;
  margin-bottom: 15px;
  color: #303133;
}

.post-content :deep(p) {
  margin-bottom: 15px;
}

.post-content :deep(code) {
  background: #f1f2f3;
  padding: 2px 6px;
  border-radius: 4px;
  font-family: 'Consolas', 'Monaco', monospace;
}

.post-content :deep(pre) {
  background: #f6f8fa;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  margin: 15px 0;
}

.post-footer {
  padding-top: 20px;
  border-top: 1px solid #e4e7ed;
}

.post-actions {
  display: flex;
  gap: 15px;
  margin-bottom: 30px;
}

.post-navigation {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
}

.nav-item {
  padding: 15px;
  border: 1px solid #e4e7ed;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s;
}

.nav-item:hover {
  border-color: #409eff;
  background: #f0f9ff;
}

.nav-item.prev {
  text-align: left;
}

.nav-item.next {
  text-align: right;
}

.nav-label {
  display: block;
  font-size: 14px;
  color: #909399;
  margin-bottom: 5px;
}

.nav-title {
  font-weight: 500;
  color: #303133;
}

.comments-section {
  background: white;
  border-radius: 8px;
  padding: 30px;
}

.comments-section h3 {
  margin: 0 0 20px 0;
  color: #303133;
  font-size: 20px;
}

.comment-form {
  margin-bottom: 30px;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 8px;
}

.comments-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.comment-item {
  padding: 15px;
  border: 1px solid #e4e7ed;
  border-radius: 8px;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.comment-author {
  font-weight: 500;
  color: #409eff;
}

.comment-date {
  font-size: 14px;
  color: #909399;
}

.comment-content {
  color: #606266;
  line-height: 1.6;
}

@media (max-width: 768px) {
  .blog-detail {
    padding: 15px;
  }
  
  .post-article {
    padding: 20px;
  }
  
  .post-title {
    font-size: 24px;
  }
  
  .post-meta {
    flex-direction: column;
    gap: 8px;
  }
  
  .post-navigation {
    grid-template-columns: 1fr;
  }
  
  .comments-section {
    padding: 20px;
  }
}
</style>
