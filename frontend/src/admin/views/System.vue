<template>
  <div class="admin-system">
    <div class="page-header">
      <h2>系统设置</h2>
    </div>
    
    <div class="settings-container">
      <el-tabs v-model="activeTab" class="settings-tabs">
        <!-- 基础设置 -->
        <el-tab-pane label="基础设置" name="basic">
          <el-form :model="basicSettings" label-width="120px">
            <el-form-item label="网站名称">
              <el-input v-model="basicSettings.siteName" />
            </el-form-item>
            <el-form-item label="网站描述">
              <el-input v-model="basicSettings.siteDescription" type="textarea" :rows="3" />
            </el-form-item>
            <el-form-item label="网站关键词">
              <el-input v-model="basicSettings.siteKeywords" />
            </el-form-item>
            <el-form-item label="备案号">
              <el-input v-model="basicSettings.beianNumber" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="saveBasicSettings">保存设置</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        
        <!-- 邮件设置 -->
        <el-tab-pane label="邮件设置" name="email">
          <el-form :model="emailSettings" label-width="120px">
            <el-form-item label="SMTP服务器">
              <el-input v-model="emailSettings.smtpHost" />
            </el-form-item>
            <el-form-item label="SMTP端口">
              <el-input v-model="emailSettings.smtpPort" type="number" />
            </el-form-item>
            <el-form-item label="发送邮箱">
              <el-input v-model="emailSettings.emailFrom" />
            </el-form-item>
            <el-form-item label="邮箱密码">
              <el-input v-model="emailSettings.emailPassword" type="password" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="saveEmailSettings">保存设置</el-button>
              <el-button @click="testEmail">测试邮件</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        
        <!-- 存储设置 -->
        <el-tab-pane label="存储设置" name="storage">
          <el-form :model="storageSettings" label-width="120px">
            <el-form-item label="存储类型">
              <el-select v-model="storageSettings.type" style="width: 200px;">
                <el-option label="本地存储" value="local" />
                <el-option label="阿里云OSS" value="aliyun" />
                <el-option label="腾讯云COS" value="tencent" />
              </el-select>
            </el-form-item>
            <el-form-item label="存储路径" v-if="storageSettings.type === 'local'">
              <el-input v-model="storageSettings.path" />
            </el-form-item>
            <el-form-item label="访问域名">
              <el-input v-model="storageSettings.domain" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="saveStorageSettings">保存设置</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        
        <!-- 系统信息 -->
        <el-tab-pane label="系统信息" name="info">
          <div class="system-info">
            <el-descriptions title="系统信息" :column="2" border>
              <el-descriptions-item label="系统版本">Blog System v1.0.0</el-descriptions-item>
              <el-descriptions-item label="Java版本">{{ systemInfo.javaVersion }}</el-descriptions-item>
              <el-descriptions-item label="Spring Boot版本">{{ systemInfo.springBootVersion }}</el-descriptions-item>
              <el-descriptions-item label="数据库版本">{{ systemInfo.databaseVersion }}</el-descriptions-item>
              <el-descriptions-item label="运行时间">{{ systemInfo.uptime }}</el-descriptions-item>
              <el-descriptions-item label="内存使用">{{ systemInfo.memoryUsage }}</el-descriptions-item>
              <el-descriptions-item label="磁盘使用">{{ systemInfo.diskUsage }}</el-descriptions-item>
              <el-descriptions-item label="CPU使用率">{{ systemInfo.cpuUsage }}</el-descriptions-item>
            </el-descriptions>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'

const activeTab = ref('basic')

// 基础设置
const basicSettings = ref({
  siteName: '个人博客',
  siteDescription: '记录技术成长的点点滴滴',
  siteKeywords: 'Vue,Spring Boot,技术博客',
  beianNumber: ''
})

// 邮件设置
const emailSettings = ref({
  smtpHost: 'smtp.163.com',
  smtpPort: 465,
  emailFrom: '',
  emailPassword: ''
})

// 存储设置
const storageSettings = ref({
  type: 'local',
  path: '/uploads',
  domain: 'http://localhost:8080'
})

// 系统信息
const systemInfo = ref({
  javaVersion: 'Java 8',
  springBootVersion: '2.7.15',
  databaseVersion: 'MySQL 8.0',
  uptime: '15 天 8 小时',
  memoryUsage: '512MB / 2GB (25%)',
  diskUsage: '8GB / 100GB (8%)',
  cpuUsage: '15%'
})

const saveBasicSettings = () => {
  // TODO: 保存基础设置
  ElMessage.success('基础设置保存成功')
}

const saveEmailSettings = () => {
  // TODO: 保存邮件设置
  ElMessage.success('邮件设置保存成功')
}

const testEmail = () => {
  // TODO: 测试邮件发送
  ElMessage.success('测试邮件发送成功')
}

const saveStorageSettings = () => {
  // TODO: 保存存储设置
  ElMessage.success('存储设置保存成功')
}

onMounted(() => {
  // TODO: 获取系统设置
})
</script>

<style scoped>
.admin-system {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: white;
  padding: 20px 24px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.page-header h2 {
  margin: 0;
  color: #303133;
  font-size: 20px;
}

.settings-container {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.settings-tabs {
  padding: 20px 24px;
}

.system-info {
  padding: 20px 0;
}
</style>
