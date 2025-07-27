import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'

// 样式文件
import 'element-plus/dist/index.css'
import '@/styles/index.scss'

// 进度条样式
import 'nprogress/nprogress.css'

// 代码高亮样式
import 'highlight.js/styles/github.css'

const app = createApp(App)

app.use(createPinia())
app.use(router)

app.mount('#app')
