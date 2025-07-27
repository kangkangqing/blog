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
        path: '/tag',
        name: 'Tag',
        component: () => import('@/views/Tag.vue'),
        meta: {
          title: '标签'
        }
      },
      {
        path: '/timeline',
        name: 'Timeline',
        component: () => import('@/views/Timeline.vue'),
        meta: {
          title: '时间线'
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
  {
    path: '/admin',
    name: 'Admin',
    component: () => import('@/admin/layout/index.vue'),
    redirect: '/admin/dashboard',
    meta: {
      requireAuth: true
    },
    children: [
      {
        path: '/admin/dashboard',
        name: 'Dashboard',
        component: () => import('@/admin/views/Dashboard.vue'),
        meta: {
          title: '仪表盘',
          requireAuth: true
        }
      },
      {
        path: '/admin/blog',
        name: 'AdminBlog',
        component: () => import('@/admin/views/Blog.vue'),
        meta: {
          title: '博客管理',
          requireAuth: true
        }
      },
      {
        path: '/admin/category',
        name: 'AdminCategory',
        component: () => import('@/admin/views/Category.vue'),
        meta: {
          title: '分类管理',
          requireAuth: true
        }
      },
      {
        path: '/admin/tag',
        name: 'AdminTag',
        component: () => import('@/admin/views/Tag.vue'),
        meta: {
          title: '标签管理',
          requireAuth: true
        }
      },
      {
        path: '/admin/user',
        name: 'AdminUser',
        component: () => import('@/admin/views/User.vue'),
        meta: {
          title: '用户管理',
          requireAuth: true
        }
      },
      {
        path: '/admin/comment',
        name: 'AdminComment',
        component: () => import('@/admin/views/Comment.vue'),
        meta: {
          title: '评论管理',
          requireAuth: true
        }
      },
      {
        path: '/admin/system',
        name: 'AdminSystem',
        component: () => import('@/admin/views/System.vue'),
        meta: {
          title: '系统设置',
          requireAuth: true
        }
      }
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login.vue'),
    meta: {
      title: '登录'
    }
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'NotFound',
    component: () => import('@/views/404.vue'),
    meta: {
      title: '页面不存在'
    }
  }
]

// 创建路由实例
const router = createRouter({
  history: createWebHistory(),
  routes
})

// 全局前置守卫
router.beforeEach((to, from, next) => {
  NProgress.start()
  
  // 设置页面标题
  if (to.meta?.title) {
    document.title = `${to.meta.title} - 个人博客系统`
  }
  
  // 权限验证
  if (to.meta?.requireAuth) {
    const token = localStorage.getItem('token')
    if (!token) {
      ElMessage.warning('请先登录')
      next('/login')
      return
    }
  }
  
  next()
})

// 全局后置钩子
router.afterEach(() => {
  NProgress.done()
})

export default router
