<template>
  <div class="auth-page">
    <!-- 背景装饰 -->
    <div class="background-decoration">
      <div class="floating-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        <div class="shape shape-3"></div>
        <div class="shape shape-4"></div>
        <div class="shape shape-5"></div>
      </div>
    </div>

    <!-- 主容器 -->
    <div class="auth-container">
      <div class="auth-card" :class="{ 'register-mode': isRegisterMode }">
        <!-- 头部logo和标题 -->
        <div class="auth-header">
          <div class="logo">
            <el-icon :size="48" color="#667eea">
              <Notebook />
            </el-icon>
          </div>
          <h1 class="title">博客管理系统</h1>
          <p class="subtitle">{{ isRegisterMode ? '注册新账户' : '欢迎回来' }}</p>
        </div>

        <!-- 表单切换标签 -->
        <div class="form-tabs">
          <div 
            class="tab" 
            :class="{ active: !isRegisterMode }" 
            @click="switchToLogin"
          >
            登录
          </div>
          <div 
            class="tab" 
            :class="{ active: isRegisterMode }" 
            @click="switchToRegister"
          >
            注册
          </div>
          <div class="tab-indicator" :class="{ 'move-right': isRegisterMode }"></div>
        </div>

        <!-- 表单内容区域 -->
        <div class="form-container">
          <!-- 登录表单 -->
          <transition name="slide-fade">
            <div v-show="!isRegisterMode" class="form-content">
              <el-form
                ref="loginFormRef"
                :model="loginForm"
                :rules="loginRules"
                class="auth-form"
                @submit.prevent="handleLogin"
              >
                <el-form-item prop="username">
                  <div class="input-wrapper">
                    <el-icon class="input-icon"><User /></el-icon>
                    <el-input
                      v-model="loginForm.username"
                      placeholder="用户名或邮箱"
                      size="large"
                      @keyup.enter="handleLogin"
                    />
                  </div>
                </el-form-item>

                <el-form-item prop="password">
                  <div class="input-wrapper">
                    <el-icon class="input-icon"><Lock /></el-icon>
                    <el-input
                      v-model="loginForm.password"
                      type="password"
                      placeholder="密码"
                      size="large"
                      show-password
                      @keyup.enter="handleLogin"
                    />
                  </div>
                </el-form-item>

                <el-form-item prop="captcha">
                  <div class="captcha-wrapper">
                    <div class="input-wrapper">
                      <el-icon class="input-icon"><Picture /></el-icon>
                      <el-input
                        v-model="loginForm.captcha"
                        placeholder="验证码"
                        size="large"
                        @keyup.enter="handleLogin"
                      />
                    </div>
                    <div class="captcha-image" @click="refreshCaptcha">
                      <img 
                        v-if="captchaUrl && !captchaLoading" 
                        :src="captchaUrl" 
                        alt="验证码"
                      />
                      <div v-else class="captcha-loading">
                        <el-icon class="loading-icon" :class="{ spinning: captchaLoading }">
                          <Refresh />
                        </el-icon>
                        <span>{{ captchaLoading ? '加载中...' : '点击刷新' }}</span>
                      </div>
                    </div>
                  </div>
                </el-form-item>

                <div class="form-options">
                  <el-checkbox v-model="loginForm.remember">记住我</el-checkbox>
                  <el-link type="primary" :underline="false" class="forgot-password">
                    忘记密码？
                  </el-link>
                </div>

                <el-button
                  type="primary"
                  size="large"
                  class="auth-button"
                  :loading="loginLoading"
                  @click="handleLogin"
                >
                  <span v-if="!loginLoading">登录</span>
                  <span v-else>登录中...</span>
                </el-button>
              </el-form>
            </div>
          </transition>

          <!-- 注册表单 -->
          <transition name="slide-fade">
            <div v-show="isRegisterMode" class="form-content">
              <el-form
                ref="registerFormRef"
                :model="registerForm"
                :rules="registerRules"
                class="auth-form"
                @submit.prevent="handleRegister"
              >
                <el-form-item prop="username">
                  <div class="input-wrapper">
                    <el-icon class="input-icon"><User /></el-icon>
                    <el-input
                      v-model="registerForm.username"
                      placeholder="用户名 (3-20位字母数字下划线)"
                      size="large"
                    />
                  </div>
                </el-form-item>

                <el-form-item prop="nickname">
                  <div class="input-wrapper">
                    <el-icon class="input-icon"><Avatar /></el-icon>
                    <el-input
                      v-model="registerForm.nickname"
                      placeholder="昵称 (1-20位)"
                      size="large"
                    />
                  </div>
                </el-form-item>

                <el-form-item prop="email">
                  <div class="input-wrapper">
                    <el-icon class="input-icon"><Message /></el-icon>
                    <el-input
                      v-model="registerForm.email"
                      placeholder="邮箱地址"
                      size="large"
                    />
                  </div>
                </el-form-item>

                <el-form-item prop="password">
                  <div class="input-wrapper">
                    <el-icon class="input-icon"><Lock /></el-icon>
                    <el-input
                      v-model="registerForm.password"
                      type="password"
                      placeholder="密码 (6-20位，包含字母和数字)"
                      size="large"
                      show-password
                    />
                  </div>
                </el-form-item>

                <el-form-item prop="confirmPassword">
                  <div class="input-wrapper">
                    <el-icon class="input-icon"><Lock /></el-icon>
                    <el-input
                      v-model="registerForm.confirmPassword"
                      type="password"
                      placeholder="确认密码"
                      size="large"
                      show-password
                    />
                  </div>
                </el-form-item>

                <el-form-item prop="captcha">
                  <div class="captcha-wrapper">
                    <div class="input-wrapper">
                      <el-icon class="input-icon"><Picture /></el-icon>
                      <el-input
                        v-model="registerForm.captcha"
                        placeholder="验证码"
                        size="large"
                      />
                    </div>
                    <div class="captcha-image" @click="refreshRegisterCaptcha">
                      <img 
                        v-if="registerCaptchaUrl && !registerCaptchaLoading" 
                        :src="registerCaptchaUrl" 
                        alt="验证码"
                      />
                      <div v-else class="captcha-loading">
                        <el-icon class="loading-icon" :class="{ spinning: registerCaptchaLoading }">
                          <Refresh />
                        </el-icon>
                        <span>{{ registerCaptchaLoading ? '加载中...' : '点击刷新' }}</span>
                      </div>
                    </div>
                  </div>
                </el-form-item>

                <el-button
                  type="primary"
                  size="large"
                  class="auth-button"
                  :loading="registerLoading"
                  @click="handleRegister"
                >
                  <span v-if="!registerLoading">注册</span>
                  <span v-else>注册中...</span>
                </el-button>
              </el-form>
            </div>
          </transition>
        </div>

        <!-- 底部链接 -->
        <div class="auth-footer">
          <el-link 
            type="primary" 
            :underline="false" 
            @click="$router.push('/')"
            class="footer-link"
          >
            <el-icon><House /></el-icon>
            返回首页
          </el-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, onBeforeUnmount, watch } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElNotification } from 'element-plus'
import type { FormInstance, FormRules } from 'element-plus'
import { 
  User, 
  Lock, 
  Picture, 
  Refresh, 
  Avatar, 
  Message, 
  House, 
  Notebook 
} from '@element-plus/icons-vue'
import { getCaptcha, login as apiLogin, register as apiRegister } from '../api/auth'
import { useUserStore } from '../stores/user'

// 组合式 API
const router = useRouter()
const userStore = useUserStore()

// 响应式数据
const isRegisterMode = ref(false)
const loginFormRef = ref<FormInstance>()
const registerFormRef = ref<FormInstance>()

// 表单数据
const loginForm = reactive({
  username: '',
  password: '',
  captcha: '',
  captchaKey: '',
  remember: false
})

const registerForm = reactive({
  username: '',
  nickname: '',
  email: '',
  password: '',
  confirmPassword: '',
  captcha: '',
  captchaKey: ''
})

// 验证码相关
const captchaUrl = ref('')
const registerCaptchaUrl = ref('')
const captchaLoading = ref(false)
const registerCaptchaLoading = ref(false)

// 加载状态
const loginLoading = ref(false)
const registerLoading = ref(false)

// 表单验证规则
const loginRules: FormRules = {
  username: [
    { required: true, message: '请输入用户名或邮箱', trigger: 'blur' },
    { min: 3, max: 50, message: '用户名长度在 3 到 50 个字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  captcha: [
    { required: true, message: '请输入验证码', trigger: 'blur' },
    { min: 4, max: 6, message: '验证码长度在 4 到 6 个字符', trigger: 'blur' }
  ]
}

const registerRules: FormRules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '用户名长度在 3 到 20 个字符', trigger: 'blur' },
    { pattern: /^[a-zA-Z0-9_]+$/, message: '用户名只能包含字母、数字和下划线', trigger: 'blur' }
  ],
  nickname: [
    { required: true, message: '请输入昵称', trigger: 'blur' },
    { min: 1, max: 20, message: '昵称长度在 1 到 20 个字符', trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '请输入有效的邮箱地址', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' },
    { pattern: /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]+$/, message: '密码必须包含字母和数字', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请再次输入密码', trigger: 'blur' },
    {
      validator: (rule, value, callback) => {
        if (value !== registerForm.password) {
          callback(new Error('两次输入的密码不一致'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ],
  captcha: [
    { required: true, message: '请输入验证码', trigger: 'blur' },
    { min: 4, max: 6, message: '验证码长度在 4 到 6 个字符', trigger: 'blur' }
  ]
}

// 方法定义
const switchToLogin = () => {
  isRegisterMode.value = false
}

const switchToRegister = () => {
  isRegisterMode.value = true
}

// 获取登录验证码
const getCaptchaImage = async () => {
  // 防止重复请求
  if (captchaLoading.value) return
  
  try {
    captchaLoading.value = true
    const response = await getCaptcha()
    
    // 清理之前的URL
    if (captchaUrl.value && captchaUrl.value.startsWith('blob:')) {
      URL.revokeObjectURL(captchaUrl.value)
    }
    
    // 将Blob转换为URL用于显示
    const imageUrl = URL.createObjectURL(response.blob)
    captchaUrl.value = imageUrl
    loginForm.captchaKey = response.captchaKey
  } catch (error: any) {
    console.error('获取验证码失败:', error)
    ElMessage.warning('验证码加载失败，请点击图片刷新')
    captchaUrl.value = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjQwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMjAiIGhlaWdodD0iNDAiIGZpbGw9IiNmNWY3ZmEiLz48dGV4dCB4PSI2MCIgeT0iMjQiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxNCIgZmlsbD0iIzk5OTk5OSIgdGV4dC1hbmNob3I9Im1pZGRsZSI+点击刷新</dGV4dD48L3N2Zz4='
  } finally {
    // 添加最小延迟，防止用户过快点击
    setTimeout(() => {
      captchaLoading.value = false
    }, 500)
  }
}

// 获取注册验证码
const getRegisterCaptchaImage = async () => {
  // 防止重复请求
  if (registerCaptchaLoading.value) return
  
  try {
    registerCaptchaLoading.value = true
    const response = await getCaptcha()
    
    // 清理之前的URL
    if (registerCaptchaUrl.value && registerCaptchaUrl.value.startsWith('blob:')) {
      URL.revokeObjectURL(registerCaptchaUrl.value)
    }
    
    // 将Blob转换为URL用于显示
    const imageUrl = URL.createObjectURL(response.blob)
    registerCaptchaUrl.value = imageUrl
    registerForm.captchaKey = response.captchaKey
  } catch (error: any) {
    console.error('获取注册验证码失败:', error)
    ElMessage.warning('验证码加载失败，请点击图片刷新')
    registerCaptchaUrl.value = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjQwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxyZWN0IHdpZHRoPSIxMjAiIGhlaWdodD0iNDAiIGZpbGw9IiNmNWY3ZmEiLz48dGV4dCB4PSI2MCIgeT0iMjQiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxNCIgZmlsbD0iIzk5OTk5OSIgdGV4dC1hbmNob3I9Im1pZGRsZSI+点击刷新</dGV4dD48L3N2Zz4='
  } finally {
    // 添加最小延迟，防止用户过快点击
    setTimeout(() => {
      registerCaptchaLoading.value = false
    }, 500)
  }
}

// 刷新验证码
const refreshCaptcha = async () => {
  // 防止重复点击
  if (captchaLoading.value) return
  
  loginForm.captcha = ''
  await getCaptchaImage()
}

const refreshRegisterCaptcha = async () => {
  // 防止重复点击
  if (registerCaptchaLoading.value) return
  
  registerForm.captcha = ''
  await getRegisterCaptchaImage()
}

// 登录处理
const handleLogin = async () => {
  if (!loginFormRef.value) return
  
  const valid = await loginFormRef.value.validate().catch(() => false)
  if (!valid) return
  
  loginLoading.value = true
  try {
    const response = await apiLogin({
      username: loginForm.username,
      password: loginForm.password,
      captcha: loginForm.captcha,
      captchaKey: loginForm.captchaKey
    })
    
    // 直接设置用户信息到store
    userStore.token = response.token
    userStore.userInfo = response.userInfo
    userStore.isLoggedIn = true
    
    // 保存到localStorage
    localStorage.setItem('admin_token', response.token)
    
    ElNotification({
      title: '登录成功',
      message: '欢迎回来！',
      type: 'success'
    })
    
    console.log('准备跳转到管理后台...')
    const redirect = router.currentRoute.value.query.redirect as string
    const targetRoute = redirect || '/test'  // 暂时跳转到测试页面
    console.log('跳转目标:', targetRoute)
    
    try {
      await router.push(targetRoute)
      console.log('路由跳转成功')
    } catch (error) {
      console.error('路由跳转失败:', error)
    }
  } catch (error: any) {
    console.error('登录错误详情:', error)
    
    // 获取错误信息
    let errorMessage = '登录失败'
    if (error.response && error.response.data && error.response.data.message) {
      errorMessage = error.response.data.message
    } else if (error.message) {
      errorMessage = error.message
    }
    
    ElMessage.error(errorMessage)
    refreshCaptcha()
  } finally {
    loginLoading.value = false
  }
}

// 注册处理
const handleRegister = async () => {
  if (!registerFormRef.value) return
  
  const valid = await registerFormRef.value.validate().catch(() => false)
  if (!valid) return
  
  registerLoading.value = true
  try {
    await apiRegister({
      username: registerForm.username,
      nickname: registerForm.nickname,
      email: registerForm.email,
      password: registerForm.password,
      confirmPassword: registerForm.confirmPassword,
      captcha: registerForm.captcha,
      captchaKey: registerForm.captchaKey
    })
    
    ElNotification({
      title: '注册成功',
      message: '请使用新账号登录',
      type: 'success'
    })
    
    // 重置注册表单并切换到登录
    registerForm.username = ''
    registerForm.nickname = ''
    registerForm.email = ''
    registerForm.password = ''
    registerForm.confirmPassword = ''
    registerForm.captcha = ''
    registerForm.captchaKey = ''
    registerFormRef.value?.resetFields()
    
    switchToLogin()
  } catch (error: any) {
    ElMessage.error(error.message || '注册失败')
    refreshRegisterCaptcha()
  } finally {
    registerLoading.value = false
  }
}

// 监听模式切换，自动获取对应验证码
watch(isRegisterMode, (newVal) => {
  if (newVal) {
    // 切换到注册模式，立即获取验证码
    getRegisterCaptchaImage()
  }
})

// 页面加载时获取登录验证码
onMounted(() => {
  getCaptchaImage()
})

// 组件卸载时清理资源
onBeforeUnmount(() => {
  // 清理验证码图片的Blob URL
  if (captchaUrl.value && captchaUrl.value.startsWith('blob:')) {
    URL.revokeObjectURL(captchaUrl.value)
  }
  if (registerCaptchaUrl.value && registerCaptchaUrl.value.startsWith('blob:')) {
    URL.revokeObjectURL(registerCaptchaUrl.value)
  }
})



</script>

<style scoped>
/* 页面基础样式 */
.auth-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  position: relative;
  overflow: hidden;
}

/* 背景装饰 */
.background-decoration {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
}

.floating-shapes {
  position: relative;
  width: 100%;
  height: 100%;
}

.shape {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  animation: float 6s ease-in-out infinite;
}

.shape-1 {
  width: 80px;
  height: 80px;
  top: 10%;
  left: 10%;
  animation-delay: 0s;
}

.shape-2 {
  width: 120px;
  height: 120px;
  top: 20%;
  right: 10%;
  animation-delay: 2s;
}

.shape-3 {
  width: 100px;
  height: 100px;
  bottom: 20%;
  left: 15%;
  animation-delay: 4s;
}

.shape-4 {
  width: 60px;
  height: 60px;
  bottom: 30%;
  right: 20%;
  animation-delay: 1s;
}

.shape-5 {
  width: 140px;
  height: 140px;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  animation-delay: 3s;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0px) rotate(0deg);
  }
  50% {
    transform: translateY(-20px) rotate(180deg);
  }
}

/* 主容器 */
.auth-container {
  width: 100%;
  max-width: 440px;
  padding: 20px;
  z-index: 1;
}

.auth-card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 20px;
  padding: 40px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
  animation: slideUp 0.8s ease-out;
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.auth-card.register-mode {
  max-height: none;
}

/* 头部样式 */
.auth-header {
  text-align: center;
  margin-bottom: 30px;
}

.logo {
  margin-bottom: 16px;
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
}

.title {
  font-size: 28px;
  font-weight: 700;
  color: #2c3e50;
  margin: 0 0 8px 0;
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.subtitle {
  font-size: 16px;
  color: #7f8c8d;
  margin: 0;
  transition: all 0.3s ease;
}

/* 表单切换标签 */
.form-tabs {
  display: flex;
  background: #f8f9fa;
  border-radius: 12px;
  margin-bottom: 30px;
  position: relative;
  padding: 4px;
}

.tab {
  flex: 1;
  text-align: center;
  padding: 12px 20px;
  cursor: pointer;
  border-radius: 8px;
  font-weight: 500;
  font-size: 14px;
  transition: all 0.3s ease;
  position: relative;
  z-index: 2;
  color: #7f8c8d;
}

.tab.active {
  color: #667eea;
  font-weight: 600;
}

.tab-indicator {
  position: absolute;
  top: 4px;
  left: 4px;
  width: calc(50% - 4px);
  height: calc(100% - 8px);
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  z-index: 1;
}

.tab-indicator.move-right {
  transform: translateX(100%);
}

/* 表单容器 */
.form-container {
  position: relative;
  overflow: hidden;
}

.form-content {
  width: 100%;
}

/* 表单样式 */
.auth-form {
  width: 100%;
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

.input-icon {
  position: absolute;
  left: 16px;
  top: 50%;
  transform: translateY(-50%);
  color: #bbb;
  z-index: 2;
  font-size: 16px;
}

.input-wrapper :deep(.el-input__wrapper) {
  padding-left: 48px;
  border-radius: 12px;
  border: 2px solid #e9ecef;
  transition: all 0.3s ease;
  background: #f8f9fa;
}

.input-wrapper :deep(.el-input__wrapper:hover) {
  border-color: #667eea;
  background: white;
}

.input-wrapper :deep(.el-input__wrapper.is-focus) {
  border-color: #667eea;
  background: white;
  box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
}

/* 验证码样式 */
.captcha-wrapper {
  display: flex;
  gap: 12px;
  align-items: center;
}

.captcha-wrapper .input-wrapper {
  flex: 1;
}

.captcha-image {
  width: 120px;
  height: 50px;
  border: 2px solid #e9ecef;
  border-radius: 12px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f8f9fa;
  transition: all 0.3s ease;
  overflow: hidden;
}

.captcha-image:hover {
  border-color: #667eea;
  background: white;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
}

.captcha-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.captcha-loading {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  color: #7f8c8d;
  font-size: 12px;
}

.loading-icon {
  font-size: 18px;
  transition: all 0.3s ease;
}

.loading-icon.spinning {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

/* 表单选项 */
.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.forgot-password {
  font-size: 14px;
  color: #667eea;
  text-decoration: none;
  transition: all 0.3s ease;
}

.forgot-password:hover {
  color: #764ba2;
}

/* 按钮样式 */
.auth-button {
  width: 100%;
  height: 48px;
  border-radius: 12px;
  font-size: 16px;
  font-weight: 600;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border: none;
  transition: all 0.3s ease;
  margin-bottom: 20px;
}

.auth-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
}

.auth-button:active {
  transform: translateY(0);
}

/* 底部样式 */
.auth-footer {
  text-align: center;
  margin-top: 20px;
}

.footer-link {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  color: #7f8c8d;
  font-size: 14px;
  text-decoration: none;
  transition: all 0.3s ease;
}

.footer-link:hover {
  color: #667eea;
  transform: translateY(-1px);
}

/* 动画效果 */
.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.slide-fade-enter-from {
  opacity: 0;
  transform: translateX(30px);
}

.slide-fade-leave-to {
  opacity: 0;
  transform: translateX(-30px);
}

/* 响应式设计 */
@media (max-width: 480px) {
  .auth-container {
    padding: 15px;
  }
  
  .auth-card {
    padding: 30px 20px;
    border-radius: 16px;
  }
  
  .title {
    font-size: 24px;
  }
  
  .captcha-wrapper {
    flex-direction: column;
    align-items: stretch;
  }
  
  .captcha-image {
    width: 100%;
    margin-top: 12px;
  }
}

/* 深色模式支持 */
@media (prefers-color-scheme: dark) {
  .auth-card {
    background: rgba(30, 30, 30, 0.95);
    color: #e0e0e0;
  }
  
  .title {
    color: #e0e0e0;
  }
  
  .subtitle {
    color: #bbb;
  }
  
  .form-tabs {
    background: rgba(255, 255, 255, 0.1);
  }
  
  .tab {
    color: #bbb;
  }
  
  .tab.active {
    color: #667eea;
  }
  
  .tab-indicator {
    background: rgba(255, 255, 255, 0.1);
  }
}
</style>
