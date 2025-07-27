<template>
  <div class="about-page">
    <div class="about-hero">
      <div class="avatar">
        <div class="avatar-placeholder">👤</div>
      </div>
      <h1>关于我</h1>
      <p>热爱技术，专注于前后端开发</p>
    </div>
    
    <div class="about-content">
      <section class="intro-section">
        <h2>个人简介</h2>
        <p>
          你好！我是一名充满热情的全栈开发者，专注于现代Web技术的学习和应用。
          在这个博客中，我会分享我在技术学习路上的心得体会，希望能够帮助到同样在学习路上的朋友们。
        </p>
      </section>
      
      <section class="skills-section">
        <h2>技术栈</h2>
        <div class="skills-grid">
          <div class="skill-category">
            <h3>前端技术</h3>
            <div class="skill-tags">
              <span class="skill-tag">Vue.js</span>
              <span class="skill-tag">React</span>
              <span class="skill-tag">TypeScript</span>
              <span class="skill-tag">JavaScript</span>
              <span class="skill-tag">HTML5</span>
              <span class="skill-tag">CSS3</span>
              <span class="skill-tag">Element Plus</span>
              <span class="skill-tag">Vite</span>
            </div>
          </div>
          
          <div class="skill-category">
            <h3>后端技术</h3>
            <div class="skill-tags">
              <span class="skill-tag">Spring Boot</span>
              <span class="skill-tag">Java</span>
              <span class="skill-tag">MyBatis-Plus</span>
              <span class="skill-tag">MySQL</span>
              <span class="skill-tag">Redis</span>
              <span class="skill-tag">Maven</span>
            </div>
          </div>
          
          <div class="skill-category">
            <h3>开发工具</h3>
            <div class="skill-tags">
              <span class="skill-tag">VS Code</span>
              <span class="skill-tag">IntelliJ IDEA</span>
              <span class="skill-tag">Git</span>
              <span class="skill-tag">Docker</span>
              <span class="skill-tag">Postman</span>
            </div>
          </div>
        </div>
      </section>
      
      <section class="contact-section">
        <h2>联系方式</h2>
        <div class="contact-info">
          <div class="contact-item">
            <span class="icon">📧</span>
            <span>sunhao@stu.cqie.edu.cn</span>
          </div>
          <div class="contact-item">
            <span class="icon">🌐</span>
            <span>GitHub: kangkangqing</span>
          </div>
          <div class="contact-item">
            <span class="icon">📍</span>
            <span>重庆市</span>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script setup lang="ts">
// 关于页面不需要复杂逻辑
</script>

<style scoped>
.about-page {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.about-hero {
  text-align: center;
  margin-bottom: 40px;
  padding: 40px 0;
  background: white;
  border-radius: 8px;
}

.avatar .avatar-placeholder {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 20px auto;
  font-size: 48px;
  color: white;
  border: 4px solid #409eff;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.about-hero h1 {
  margin: 0 0 10px 0;
  color: #303133;
  font-size: 32px;
}

.about-hero p {
  margin: 0;
  color: #909399;
  font-size: 16px;
}

.about-content {
  background: white;
  border-radius: 8px;
  padding: 30px;
}

.intro-section,
.skills-section,
.contact-section {
  margin-bottom: 40px;
}

.intro-section:last-child,
.skills-section:last-child,
.contact-section:last-child {
  margin-bottom: 0;
}

h2 {
  color: #303133;
  font-size: 24px;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 2px solid #409eff;
}

.intro-section p {
  color: #606266;
  line-height: 1.8;
  font-size: 16px;
}

.skills-grid {
  display: grid;
  gap: 20px;
}

.skill-category h3 {
  color: #409eff;
  font-size: 18px;
  margin-bottom: 15px;
}

.skill-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.skill-tag {
  background: #f0f9ff;
  color: #409eff;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 14px;
  border: 1px solid #e1f3ff;
}

.contact-info {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 16px;
  color: #606266;
}

.contact-item .icon {
  font-size: 20px;
  width: 24px;
}

@media (max-width: 768px) {
  .about-page {
    padding: 15px;
  }
  
  .about-content {
    padding: 20px;
  }
  
  .avatar .avatar-placeholder {
    width: 100px;
    height: 100px;
    font-size: 40px;
  }
  
  .about-hero h1 {
    font-size: 28px;
  }
  
  h2 {
    font-size: 20px;
  }
}
</style>
