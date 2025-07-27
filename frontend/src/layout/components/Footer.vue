<template>
  <footer class="footer">
    <div class="container">
      <div class="footer-content">
        <!-- 网站信息 -->
        <div class="site-info">
          <h3>个人博客</h3>
          <p>记录技术成长的点点滴滴</p>
          <div class="social-links">
            <a href="#" class="social-link" title="GitHub">
              <el-icon><Position /></el-icon>
            </a>
            <a href="#" class="social-link" title="邮箱">
              <el-icon><Message /></el-icon>
            </a>
            <a href="#" class="social-link" title="微博">
              <el-icon><Share /></el-icon>
            </a>
          </div>
        </div>
        
        <!-- 快速链接 -->
        <div class="quick-links">
          <h4>快速链接</h4>
          <ul>
            <li><router-link to="/home">首页</router-link></li>
            <li><router-link to="/category">分类</router-link></li>
            <li><router-link to="/tag">标签</router-link></li>
            <li><router-link to="/archive">归档</router-link></li>
            <li><router-link to="/about">关于我</router-link></li>
          </ul>
        </div>
        
        <!-- 最新文章 -->
        <div class="recent-posts">
          <h4>最新文章</h4>
          <ul>
            <li v-for="post in recentPosts" :key="post.id">
              <router-link :to="`/post/${post.id}`">{{ post.title }}</router-link>
            </li>
          </ul>
        </div>
        
        <!-- 联系信息 -->
        <div class="contact-info">
          <h4>联系方式</h4>
          <p>
            <el-icon><Message /></el-icon>
            <span>sunhao@stu.cqie.edu.cn</span>
          </p>
          <p>
            <el-icon><Position /></el-icon>
            <span>重庆市</span>
          </p>
        </div>
      </div>
      
      <!-- 版权信息 -->
      <div class="copyright">
        <div class="copyright-text">
          <p>&copy; {{ currentYear }} 个人博客. All rights reserved.</p>
          <p>
            <span>技术栈：Vue 3 + Spring Boot</span>
            <span class="divider">|</span>
            <span>主题：Simple Blog</span>
          </p>
        </div>
        <div class="footer-stats">
          <span>网站运行：{{ runningDays }} 天</span>
          <span class="divider">|</span>
          <span>文章总数：{{ totalPosts }} 篇</span>
          <span class="divider">|</span>
          <span>总访问量：{{ totalViews }} 次</span>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { Position, Message, Share } from '@element-plus/icons-vue'

// 当前年份
const currentYear = computed(() => new Date().getFullYear())

// 网站统计数据
const totalPosts = ref(0)
const totalViews = ref(0)
const runningDays = ref(0)

// 最新文章列表
const recentPosts = ref([
  { id: 1, title: 'Vue 3 Composition API 深度解析' },
  { id: 2, title: 'Spring Boot 最佳实践指南' },
  { id: 3, title: 'TypeScript 类型系统详解' },
  { id: 4, title: 'MySQL 性能优化实战' },
  { id: 5, title: 'Redis 缓存设计模式' }
])

// 计算网站运行天数
const calculateRunningDays = () => {
  const startDate = new Date('2024-01-01') // 网站启动日期
  const currentDate = new Date()
  const timeDiff = currentDate.getTime() - startDate.getTime()
  runningDays.value = Math.floor(timeDiff / (1000 * 3600 * 24))
}

// 获取网站统计数据
const fetchSiteStats = async () => {
  try {
    // TODO: 从API获取真实数据
    totalPosts.value = 128
    totalViews.value = 15672
  } catch (error) {
    console.error('获取网站统计数据失败:', error)
  }
}

onMounted(() => {
  calculateRunningDays()
  fetchSiteStats()
})
</script>

<style scoped>
.footer {
  background-color: #2c3e50;
  color: #ecf0f1;
  padding: 40px 0 0;
  margin-top: auto;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.footer-content {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 40px;
  padding-bottom: 30px;
}

.site-info h3 {
  margin: 0 0 15px 0;
  color: #3498db;
  font-size: 24px;
}

.site-info p {
  margin: 0 0 20px 0;
  color: #bdc3c7;
  line-height: 1.6;
}

.social-links {
  display: flex;
  gap: 15px;
}

.social-link {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  background-color: #34495e;
  color: #ecf0f1;
  border-radius: 50%;
  text-decoration: none;
  transition: all 0.3s;
}

.social-link:hover {
  background-color: #3498db;
  transform: translateY(-2px);
}

.quick-links h4,
.recent-posts h4,
.contact-info h4 {
  margin: 0 0 20px 0;
  color: #3498db;
  font-size: 18px;
  font-weight: 600;
}

.quick-links ul,
.recent-posts ul {
  list-style: none;
  margin: 0;
  padding: 0;
}

.quick-links li,
.recent-posts li {
  margin-bottom: 10px;
}

.quick-links a,
.recent-posts a {
  color: #bdc3c7;
  text-decoration: none;
  transition: color 0.3s;
  line-height: 1.6;
}

.quick-links a:hover,
.recent-posts a:hover {
  color: #3498db;
}

.recent-posts a {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.contact-info p {
  display: flex;
  align-items: center;
  gap: 10px;
  margin: 0 0 10px 0;
  color: #bdc3c7;
  line-height: 1.6;
}

.contact-info .el-icon {
  color: #3498db;
  font-size: 16px;
}

.copyright {
  border-top: 1px solid #34495e;
  padding: 20px 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
}

.copyright-text p {
  margin: 0;
  color: #95a5a6;
  font-size: 14px;
  line-height: 1.5;
}

.footer-stats {
  color: #95a5a6;
  font-size: 14px;
}

.divider {
  margin: 0 10px;
  color: #7f8c8d;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .footer-content {
    grid-template-columns: 1fr;
    gap: 30px;
  }
  
  .copyright {
    flex-direction: column;
    text-align: center;
    gap: 15px;
  }
  
  .footer-stats {
    display: flex;
    flex-direction: column;
    gap: 5px;
  }
  
  .footer-stats .divider {
    display: none;
  }
}

@media (max-width: 480px) {
  .container {
    padding: 0 15px;
  }
  
  .footer {
    padding: 30px 0 0;
  }
  
  .footer-content {
    gap: 25px;
  }
  
  .social-links {
    justify-content: center;
  }
}
</style>
