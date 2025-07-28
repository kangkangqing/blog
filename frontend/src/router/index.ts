import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import NProgress from 'nprogress'
import { ElMessage } from 'element-plus'

// 路由配置
const routes: RouteRecordRaw[] = [
  {
    path: '/',
    name: 'Layout',
    component: () => import('@/layout/index.vue'),
    redirect: '/home',
    children: [
      {
        path: '/home',
        name: 'Home',
        component: () => import('@/views/Home.vue'),
        meta: {
          title: '首页'
        }
      },
      {
        path: '/category',
        name: 'Category',
        component: () => import('@/views/Category.vue'),
        meta: {
          title: '分类'
        }
      },
      {
        path: '/archive',
        name: 'Archive',
        component: () => import('@/views/Timeline.vue'),
        meta: {
          title: '归档'
        }
      },
      {
        path: '/tag',
        name: 'Tag',
        component: () => import('@/views/Tag.vue'),
        meta: {
          title: '标签'
        }
      },
      {
        path: '/about',
        name: 'About',
        component: () => import('@/views/About.vue'),
        meta: {
          title: '关于'
        }
      },
      {
        path: '/blog/:id',
        name: 'BlogDetail',
        component: () => import('@/views/BlogDetail.vue'),
        meta: {
          title: '文章详情'
        }
      },
      {
        path: '/category/:id',
        name: 'CategoryDetail',
        component: () => import('@/views/CategoryDetail.vue'),
        meta: {
          title: '分类详情'
        }
      },
      {
        path: '/tag/:id',
        name: 'TagDetail',
        component: () => import('@/views/TagDetail.vue'),
        meta: {
          title: '标签详情'
        }
      }
    ]
  },
  // 登录页面
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login.vue'),
    meta: {
      title: '登录'
    }
  },
  // 测试页面
  {
    path: '/test',
    name: 'Test',
    component: () => import('@/views/Test.vue'),
    meta: {
      title: '测试页面'
    }
  },
  // 管理后台
  {
    path: '/admin',
    name: 'Admin',
    component: () => import('@/views/admin/Layout.vue'),
    redirect: '/admin/dashboard',
    meta: {
      requireAuth: true
    },
    children: [
      {
        path: '/admin/dashboard',
        name: 'AdminDashboard',
        component: () => import('@/views/admin/Dashboard.vue'),
        meta: {
          title: '仪表盘',
          requireAuth: true
        }
      }
    ]
  },
  // 404页面
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFound',
    component: () => import('@/views/404.vue'),
    meta: {
      title: '页面不存在'
    }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    }
    return { top: 0 }
  }
})

// 路由守卫
router.beforeEach(async (to, from, next) => {
  NProgress.start()
  
  // 设置页面标题
  if (to.meta.title) {
    document.title = `${to.meta.title} - 博客系统`
  }
  
  // 检查登录状态
  if (to.meta.requireAuth) {
    const token = localStorage.getItem('admin_token')
    if (!token) {
      ElMessage.warning('请先登录')
      next('/login')
      return
    }
  }
  
  next()
})

router.afterEach(() => {
  NProgress.done()
})

export default router
