<template>
  <div class="home">
    <!-- 轮播图/横幅 -->
    <section class="hero-section">
      <el-carousel :interval="5000" type="card" height="300px">
        <el-carousel-item v-for="item in bannerList" :key="item.id">
          <div class="banner-item" :class="`banner-${item.id}`">
            <div class="banner-content">
              <h2>{{ item.title }}</h2>
              <p>{{ item.description }}</p>
              <el-button type="primary" @click="viewPost(item.postId)" v-if="item.postId">
                阅读全文
              </el-button>
            </div>
          </div>
        </el-carousel-item>
      </el-carousel>
    </section>

    <!-- 主要内容区域 -->
    <div class="main-container">
      <!-- 文章列表 -->
      <div class="content-area">
        <!-- 筛选和搜索 -->
        <div class="filter-section">
          <div class="filter-tabs">
            <el-radio-group v-model="activeFilter" @change="handleFilterChange">
              <el-radio-button value="latest">最新文章</el-radio-button>
              <el-radio-button value="hot">热门文章</el-radio-button>
              <el-radio-button value="recommend">推荐文章</el-radio-button>
            </el-radio-group>
          </div>
          <div class="search-area">
            <el-input
              v-model="searchKeyword"
              placeholder="搜索文章..."
              prefix-icon="Search"
              @keyup.enter="handleSearch"
              style="width: 300px"
            />
          </div>
        </div>

        <!-- 文章卡片列表 -->
        <div class="post-list">
          <div
            v-for="post in postList"
            :key="post.id"
            class="post-card"
            @click="viewPost(post.id)"
          >
            <div class="post-image" v-if="post.coverImage">
              <div class="image-placeholder">
                <el-icon><Picture /></el-icon>
              </div>
            </div>
            <div class="post-content">
              <div class="post-meta">
                <span class="category">{{ post.categoryName }}</span>
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
                  @click.stop="viewTag(tag.id)"
                >
                  {{ tag.name }}
                </el-tag>
              </div>
              <div class="post-actions">
                <span class="like-count">
                  ♥ {{ post.likeCount }}
                </span>
                <span class="comment-count">
                  💬 {{ post.commentCount }}
                </span>
              </div>
            </div>
          </div>
        </div>

        <!-- 分页 -->
        <div class="pagination-wrapper">
          <el-pagination
            :current-page="currentPage"
            :page-size="pageSize"
            :page-sizes="[10, 20, 50]"
            :total="total"
            layout="total, sizes, prev, pager, next, jumper"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
          />
        </div>
      </div>

      <!-- 侧边栏 -->
      <aside class="sidebar">
        <!-- 个人简介 -->
        <div class="widget author-info">
          <div class="author-avatar">
            <div class="avatar-placeholder">👤</div>
          </div>
          <h3>博主简介</h3>
          <p>热爱技术，专注于前后端开发，分享学习心得与技术经验。</p>
          <div class="author-stats">
            <div class="stat-item">
              <span class="number">{{ totalPosts }}</span>
              <span class="label">文章</span>
            </div>
            <div class="stat-item">
              <span class="number">{{ totalCategories }}</span>
              <span class="label">分类</span>
            </div>
            <div class="stat-item">
              <span class="number">{{ totalTags }}</span>
              <span class="label">标签</span>
            </div>
          </div>
        </div>

        <!-- 热门文章 -->
        <div class="widget hot-posts">
          <h3>热门文章</h3>
          <ul>
            <li v-for="post in hotPosts" :key="post.id" @click="viewPost(post.id)">
              <span class="post-title">{{ post.title }}</span>
              <span class="post-views">{{ post.viewCount }} 阅读</span>
            </li>
          </ul>
        </div>

        <!-- 分类标签云 -->
        <div class="widget tag-cloud">
          <h3>标签云</h3>
          <div class="tags">
            <el-tag
              v-for="tag in tagCloud"
              :key="tag.id"
              :size="getTagSize(tag.postCount)"
              effect="plain"
              @click="viewTag(tag.id)"
              style="margin: 4px;"
            >
              {{ tag.name }} ({{ tag.postCount }})
            </el-tag>
          </div>
        </div>

        <!-- 最新评论 -->
        <div class="widget recent-comments">
          <h3>最新评论</h3>
          <ul>
            <li v-for="comment in recentComments" :key="comment.id">
              <div class="comment-author">{{ comment.authorName }}</div>
              <div class="comment-content">{{ comment.content }}</div>
              <div class="comment-post">
                在 <a @click="viewPost(comment.postId)">{{ comment.postTitle }}</a>
              </div>
            </li>
          </ul>
        </div>
      </aside>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Picture } from '@element-plus/icons-vue'

const router = useRouter()

// 筛选状态
const activeFilter = ref('latest')
const searchKeyword = ref('')

// 分页参数
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

// 轮播图数据
const bannerList = ref([
  {
    id: 1,
    title: '欢迎来到我的博客',
    description: '在这里记录技术成长的点点滴滴',
    image: 'gradient1',
    postId: null
  },
  {
    id: 2,
    title: 'Vue 3 深度解析',
    description: '探索Vue 3的新特性和最佳实践',
    image: 'gradient2',
    postId: 1
  }
])

// 文章列表
const postList = ref([])

// 侧边栏数据
const totalPosts = ref(0)
const totalCategories = ref(0)
const totalTags = ref(0)
const hotPosts = ref([])
const tagCloud = ref([])
const recentComments = ref([])

// 获取文章列表
const getPostList = async () => {
  try {
    // TODO: 调用API获取文章列表
    const mockData = {
      data: [
        {
          id: 1,
          title: 'Vue 3 Composition API 深度解析',
          summary: 'Vue 3 引入了全新的 Composition API，为开发者提供了更灵活的组件逻辑组织方式...',
          coverImage: 'placeholder',
          categoryName: 'Vue.js',
          createTime: '2024-01-15T10:30:00',
          viewCount: 1250,
          likeCount: 45,
          commentCount: 12,
          tags: [
            { id: 1, name: 'Vue3' },
            { id: 2, name: 'JavaScript' }
          ]
        },
        {
          id: 2,
          title: 'Spring Boot 最佳实践指南',
          summary: '本文将介绍Spring Boot开发中的最佳实践，包括项目结构、配置管理、异常处理等...',
          coverImage: 'placeholder',
          categoryName: 'Spring Boot',
          createTime: '2024-01-10T14:20:00',
          viewCount: 980,
          likeCount: 38,
          commentCount: 8,
          tags: [
            { id: 3, name: 'Spring Boot' },
            { id: 4, name: 'Java' }
          ]
        }
      ],
      total: 25
    }
    
    postList.value = mockData.data
    total.value = mockData.total
  } catch (error) {
    console.error('获取文章列表失败:', error)
  }
}

// 获取侧边栏数据
const getSidebarData = async () => {
  try {
    // TODO: 调用API获取侧边栏数据
    totalPosts.value = 25
    totalCategories.value = 8
    totalTags.value = 15
    
    hotPosts.value = [
      { id: 1, title: 'Vue 3 Composition API 深度解析', viewCount: 1250 },
      { id: 2, title: 'Spring Boot 最佳实践指南', viewCount: 980 },
      { id: 3, title: 'TypeScript 类型系统详解', viewCount: 856 }
    ]
    
    tagCloud.value = [
      { id: 1, name: 'Vue3', postCount: 8 },
      { id: 2, name: 'JavaScript', postCount: 12 },
      { id: 3, name: 'Spring Boot', postCount: 6 },
      { id: 4, name: 'Java', postCount: 10 }
    ]
    
    recentComments.value = [
      {
        id: 1,
        authorName: '张三',
        content: '写得很好，学到了很多！',
        postId: 1,
        postTitle: 'Vue 3 Composition API 深度解析'
      }
    ]
  } catch (error) {
    console.error('获取侧边栏数据失败:', error)
  }
}

// 格式化日期
const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('zh-CN')
}

// 获取标签大小
const getTagSize = (count: number) => {
  if (count > 10) return 'large'
  if (count > 5) return 'default'
  return 'small'
}

// 查看文章详情
const viewPost = (postId: number) => {
  router.push(`/blog/${postId}`)
}

// 查看标签
const viewTag = (tagId: number) => {
  router.push(`/tag/${tagId}`)
}

// 处理筛选变化
const handleFilterChange = () => {
  currentPage.value = 1
  getPostList()
}

// 处理搜索
const handleSearch = () => {
  if (searchKeyword.value.trim()) {
    router.push({
      path: '/search',
      query: { keyword: searchKeyword.value }
    })
  }
}

// 处理分页
const handleSizeChange = () => {
  currentPage.value = 1
  getPostList()
}

const handleCurrentChange = () => {
  getPostList()
}

onMounted(() => {
  getPostList()
  getSidebarData()
})
</script>

<style scoped>
.home {
  background-color: #f8f9fa;
}

.hero-section {
  margin-bottom: 30px;
}

.banner-item {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  border-radius: 8px;
  overflow: hidden;
}

.banner-1 {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.banner-2 {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.banner-item::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.3);
}

.banner-content {
  position: relative;
  text-align: center;
  color: white;
  z-index: 1;
}

.banner-content h2 {
  font-size: 28px;
  margin-bottom: 10px;
}

.banner-content p {
  font-size: 16px;
  margin-bottom: 20px;
}

.main-container {
  display: grid;
  grid-template-columns: 1fr 300px;
  gap: 30px;
  max-width: 1200px;
  margin: 0 auto;
}

.filter-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 20px;
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.post-list {
  display: grid;
  gap: 20px;
}

.post-card {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s, box-shadow 0.3s;
  cursor: pointer;
  display: grid;
  grid-template-columns: 200px 1fr;
  gap: 20px;
}

.post-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.post-image {
  height: 150px;
  overflow: hidden;
}

.post-image .image-placeholder {
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #909399;
  font-size: 32px;
}

.post-content {
  padding: 20px 20px 20px 0;
  display: flex;
  flex-direction: column;
}

.post-meta {
  display: flex;
  gap: 15px;
  margin-bottom: 10px;
  font-size: 14px;
  color: #666;
}

.category {
  color: #409eff;
  font-weight: 500;
}

.post-title {
  margin: 0 0 10px 0;
  font-size: 20px;
  font-weight: 600;
  color: #303133;
  line-height: 1.4;
}

.post-summary {
  margin: 0 0 15px 0;
  color: #606266;
  line-height: 1.6;
  flex: 1;
}

.post-tags {
  margin-bottom: 15px;
}

.post-tags .el-tag {
  margin-right: 8px;
  cursor: pointer;
}

.post-actions {
  display: flex;
  gap: 20px;
  color: #909399;
  font-size: 14px;
}

.post-actions span {
  display: flex;
  align-items: center;
  gap: 4px;
}

.pagination-wrapper {
  margin-top: 30px;
  text-align: center;
}

.sidebar {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.widget {
  background: white;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.widget h3 {
  margin: 0 0 15px 0;
  font-size: 18px;
  color: #303133;
  border-bottom: 2px solid #409eff;
  padding-bottom: 8px;
}

.author-info {
  text-align: center;
}

.author-avatar .avatar-placeholder {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 15px auto;
  font-size: 36px;
  color: white;
  border: 4px solid #fff;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.author-stats {
  display: flex;
  justify-content: space-around;
  margin-top: 20px;
}

.stat-item {
  text-align: center;
}

.stat-item .number {
  display: block;
  font-size: 24px;
  font-weight: bold;
  color: #409eff;
}

.stat-item .label {
  font-size: 14px;
  color: #909399;
}

.hot-posts ul,
.recent-comments ul {
  list-style: none;
  margin: 0;
  padding: 0;
}

.hot-posts li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid #f0f0f0;
  cursor: pointer;
}

.hot-posts li:hover {
  color: #409eff;
}

.hot-posts .post-title {
  flex: 1;
  font-size: 14px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.hot-posts .post-views {
  font-size: 12px;
  color: #909399;
}

.recent-comments li {
  padding: 10px 0;
  border-bottom: 1px solid #f0f0f0;
}

.comment-author {
  font-weight: 500;
  color: #303133;
  font-size: 14px;
}

.comment-content {
  color: #606266;
  font-size: 13px;
  margin: 4px 0;
}

.comment-post {
  font-size: 12px;
  color: #909399;
}

.comment-post a {
  color: #409eff;
  cursor: pointer;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .main-container {
    grid-template-columns: 1fr;
  }
  
  .post-card {
    grid-template-columns: 1fr;
  }
  
  .post-image {
    height: 200px;
  }
  
  .filter-section {
    flex-direction: column;
    gap: 15px;
  }
  
  .search-area {
    width: 100%;
  }
  
  .search-area .el-input {
    width: 100% !important;
  }
}
</style>
