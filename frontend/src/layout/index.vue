<template>
  <div class="layout-container">
    <!-- 顶部导航栏 -->
    <Header />
    
    <!-- 主要内容区域 -->
    <main class="main-content">
      <div class="container">
        <router-view />
      </div>
    </main>
    
    <!-- 底部 -->
    <Footer />
  </div>
</template>

<script setup lang="ts">
import Header from './components/Header.vue'
import Footer from './components/Footer.vue'
</script>

<style scoped>
.layout-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.main-content {
  flex: 1;
  padding: 20px 0;
  background-color: #f8f9fa;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

@media (max-width: 768px) {
  .container {
    padding: 0 15px;
  }
}
</style>
