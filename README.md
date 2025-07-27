# 🚀 个人博客系统 (Personal Blog System)

[![Java](https://img.shields.io/badge/Java-8-orange)](https://www.oracle.com/java/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.7.15-brightgreen)](https://spring.io/projects/spring-boot)
[![Vue](https://img.shields.io/badge/Vue-3.3.8-4fc08d)](https://vuejs.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](https://opensource.org/licenses/MIT)

## 📋 项目概述

这是一个基于 **Spring Boot + Vue3** 的现代化前后端分离个人博客系统，采用最新技术栈构建，具有完整的博客功能和管理后台。项目遵循RESTful API设计规范，支持响应式布局，适合个人开发者快速搭建专业的博客网站。

### ✨ 核心特性

- 🎨 **现代化UI设计** - 基于Element Plus的响应式界面
- � **安全认证** - Sa-Token + JWT 双重安全保障
- 📚 **完整文档** - SpringDoc OpenAPI 3.0 自动生成API文档
- 🚀 **高性能** - Redis缓存 + MyBatis-Plus优化
- 📱 **移动适配** - 完美支持移动端访问
- �🛠️ **易部署** - Docker容器化部署支持

## 🛠️ 技术栈

### 后端技术栈
| 技术 | 版本 | 说明 |
|------|------|------|
| **Java** | 1.8 | 开发语言 |
| **Spring Boot** | 2.7.15 | 主框架 |
| **MyBatis-Plus** | 3.5.3.2 | ORM框架增强 |
| **MySQL** | 8.0.33 | 主数据库 |
| **Redis** | Latest | 缓存数据库 |
| **Sa-Token** | 1.37.0 | 权限认证框架 |
| **SpringDoc OpenAPI** | 1.7.0 | API文档生成 |
| **FastJSON** | 2.0.40 | JSON处理 |
| **Hutool** | 5.8.21 | Java工具库 |

### 前端技术栈
| 技术 | 版本 | 说明 |
|------|------|------|
| **Vue 3** | 3.3.8 | 前端框架 |
| **TypeScript** | 5.2.0 | 开发语言 |
| **Element Plus** | 2.4.4 | UI组件库 |
| **Pinia** | 2.1.7 | 状态管理 |
| **Vue Router** | 4.2.5 | 路由管理 |
| **Axios** | 1.6.2 | HTTP客户端 |
| **Vite** | 5.0.0 | 构建工具 |
| **ECharts** | 5.4.3 | 数据可视化 |

### 开发工具
- **VS Code** - 推荐代码编辑器
- **Git** - 版本控制
- **Maven** - 项目构建
- **Docker** - 容器化部署

## 🏗️ 系统架构

```
┌─────────────────┐    HTTP/HTTPS    ┌─────────────────┐
│   Vue3 前端     │ ────────────────► │  Spring Boot    │
│  Element Plus   │                   │   Sa-Token      │
│   (端口:5173)   │                   │  (端口:8080)    │
└─────────────────┘                   └─────────────────┘
                                             │
                                             ▼
                                      ┌─────────────────┐
                                      │     MySQL       │
                                      │   (端口:3306)   │
                                      └─────────────────┘
                                             │
                                             ▼
                                      ┌─────────────────┐
                                      │     Redis       │
                                      │   (端口:6379)   │
                                      └─────────────────┘
```

## 📊 业务功能

### 🎯 核心业务模块

#### 👤 用户管理
- ✅ 用户注册/登录
- ✅ 个人信息管理
- ✅ 密码修改
- ✅ 头像上传
- ✅ 权限控制

#### 📝 博客管理
- ✅ 文章发布/编辑
- ✅ 文章分类管理
- ✅ 标签管理
- ✅ 文章搜索
- ✅ 文章统计
- ✅ 封面图片上传

#### 💬 评论系统
- ✅ 文章评论
- ✅ 评论回复
- ✅ 评论管理
- ✅ 评论审核

#### 🎨 前台功能
- ✅ 博客首页展示
- ✅ 文章详情页
- ✅ 分类/标签页面
- ✅ 时间轴展示
- ✅ 关于页面
- ✅ 搜索功能

#### 🔧 后台管理
- ✅ 仪表盘统计
- ✅ 文章管理
- ✅ 分类管理
- ✅ 标签管理
- ✅ 用户管理
- ✅ 评论管理
- ✅ 系统设置

### 🔐 权限设计
- **Sa-Token认证** - 轻量级权限认证框架
- **JWT Token** - 无状态认证
- **Redis存储** - Token缓存管理
- **路由守卫** - 前端权限控制

## 🚀 快速开始

### 📋 环境要求
- **JDK 8+**
- **Node.js 16+**
- **MySQL 8.0+**
- **Redis 6.0+**
- **Maven 3.6+**

### 🔧 后端启动

1. **克隆项目**
```bash
git clone https://github.com/kangkangqing/blog.git
cd blog
```

2. **配置数据库**
```sql
-- 创建数据库
CREATE DATABASE blog CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

3. **修改配置**
```yaml
# backend/src/main/resources/application.yml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/blog?useUnicode=true&characterEncoding=utf8mb4&serverTimezone=Asia/Shanghai
    username: your_username
    password: your_password
  redis:
    host: localhost
    port: 6379
    password: your_redis_password
```

4. **启动后端**
```bash
cd backend
mvn clean package -DskipTests
java -jar target/blog-backend-1.0.0.jar
```

### 🎨 前端启动

1. **安装依赖**
```bash
cd frontend
npm install
```

2. **启动开发服务器**
```bash
npm run dev
```

3. **构建生产版本**
```bash
npm run build
```

### 🌐 访问地址
- **前台首页**: http://localhost:5173
- **管理后台**: http://localhost:5173/admin
- **API文档**: http://localhost:8080/swagger-ui.html

## 📚 API文档

本项目使用 **SpringDoc OpenAPI 3** 自动生成API文档，支持在线测试：

- **Swagger UI**: `http://localhost:8080/swagger-ui.html`
- **OpenAPI JSON**: `http://localhost:8080/v3/api-docs`

### 🔑 认证方式
API使用Bearer Token认证，请在请求头中添加：
```
Authorization: Bearer {your_token}
```

## 📁 项目结构
```
blog/
├── backend/                          # Spring Boot 后端
│   ├── src/main/java/com/blog/
│   │   ├── BlogApplication.java      # 启动类
│   │   ├── config/                   # 配置类
│   │   │   └── OpenApiConfig.java    # SpringDoc配置
│   │   ├── controller/               # 控制器层
│   │   │   ├── BlogController.java   # 博客控制器
│   │   │   ├── UserController.java   # 用户控制器
│   │   │   ├── CategoryController.java# 分类控制器
│   │   │   └── TestController.java   # 测试控制器
│   │   ├── entity/                   # 实体类
│   │   ├── mapper/                   # 数据访问层
│   │   └── common/                   # 公共类
│   ├── src/main/resources/
│   │   ├── application.yml          # 主配置文件
│   │   └── mapper/                  # MyBatis XML文件
│   └── pom.xml                      # Maven配置
│
├── frontend/                        # Vue3 前端
│   ├── src/
│   │   ├── layout/                  # 布局组件
│   │   │   ├── index.vue            # 主布局
│   │   │   ├── Header.vue           # 头部组件
│   │   │   └── Footer.vue           # 底部组件
│   │   ├── views/                   # 页面组件
│   │   │   ├── Home.vue             # 首页
│   │   │   ├── BlogDetail.vue       # 博客详情
│   │   │   ├── Category.vue         # 分类页面
│   │   │   ├── About.vue            # 关于页面
│   │   │   ├── Timeline.vue         # 时间轴
│   │   │   └── Login.vue            # 登录页面
│   │   ├── admin/                   # 管理后台
│   │   │   ├── layout/index.vue     # 后台布局
│   │   │   └── views/               # 后台页面
│   │   │       ├── Dashboard.vue    # 仪表盘
│   │   │       ├── Blog.vue         # 博客管理
│   │   │       ├── Category.vue     # 分类管理
│   │   │       ├── Tag.vue          # 标签管理
│   │   │       ├── User.vue         # 用户管理
│   │   │       ├── Comment.vue      # 评论管理
│   │   │       └── System.vue       # 系统设置
│   │   ├── router/                  # 路由配置
│   │   ├── styles/                  # 样式文件
│   │   └── main.ts                  # 入口文件
│   ├── package.json                 # npm配置
│   └── vite.config.ts              # Vite配置
│
├── docs/                           # 项目文档
├── .gitignore                      # Git忽略文件
└── README.md                       # 项目说明
```

## 🎯 核心功能模块

### 👤 用户管理模块
- **用户注册/登录** - Sa-Token + JWT认证
- **个人信息管理** - 昵称、邮箱、头像修改
- **权限控制** - 基于角色的访问控制

### 📝 内容管理模块
- **文章管理** - 发布、编辑、删除、草稿保存
- **分类管理** - 文章分类组织
- **标签管理** - 文章标签标记
- **富文本编辑** - Markdown支持

### 💬 互动模块
- **评论系统** - 文章评论与回复
- **点赞功能** - 文章点赞统计
- **浏览统计** - 文章访问量统计

### 🎨 前台展示
- **响应式首页** - 文章列表、分类导航
- **文章详情页** - Markdown渲染、评论展示
- **分类页面** - 按分类查看文章
- **时间轴** - 文章发布时间线
- **搜索功能** - 全文搜索

### 🔧 后台管理
- **数据仪表盘** - 文章、用户、评论统计
- **内容管理** - 文章、分类、标签管理
- **用户管理** - 用户信息、权限管理
- **系统设置** - 站点配置

## 🗄️ 数据库设计

### 主要数据表

#### 博客表 (blog)
```sql
CREATE TABLE `blog` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `content` longtext COMMENT '内容',
  `summary` varchar(500) COMMENT '摘要',
  `cover_image` varchar(200) COMMENT '封面图',
  `category_id` bigint COMMENT '分类ID',
  `view_count` int DEFAULT '0' COMMENT '浏览次数',
  `like_count` int DEFAULT '0' COMMENT '点赞次数',
  `status` tinyint DEFAULT '1' COMMENT '状态：0草稿 1发布',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='博客表';
```

#### 分类表 (category)
```sql
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `description` varchar(200) COMMENT '分类描述',
  `sort` int DEFAULT '0' COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分类表';
```

#### 用户表 (user)
```sql
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `email` varchar(100) COMMENT '邮箱',
  `nickname` varchar(50) COMMENT '昵称',
  `avatar` varchar(200) COMMENT '头像',
  `status` tinyint DEFAULT '1' COMMENT '状态：0禁用 1启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
```

## � API 接口

### 博客相关接口
- `GET /api/blog/list` - 获取博客列表
- `GET /api/blog/{id}` - 获取博客详情
- `POST /api/blog` - 创建博客
- `PUT /api/blog/{id}` - 更新博客
- `DELETE /api/blog/{id}` - 删除博客

### 分类相关接口
- `GET /api/category/list` - 获取分类列表
- `POST /api/category` - 创建分类
- `PUT /api/category/{id}` - 更新分类
- `DELETE /api/category/{id}` - 删除分类

### 用户相关接口
- `POST /api/user/login` - 用户登录
- `POST /api/user/register` - 用户注册
- `GET /api/user/info` - 获取用户信息
- `PUT /api/user/info` - 更新用户信息

## 🚀 部署指南

### Docker 部署（推荐）

1. **构建镜像**
```bash
# 后端镜像
cd backend
docker build -t blog-backend .

# 前端镜像
cd frontend
docker build -t blog-frontend .
```

2. **使用 Docker Compose**
```yaml
version: '3.8'
services:
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: blog
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql

  redis:
    image: redis:6.2-alpine
    ports:
      - "6379:6379"

  backend:
    image: blog-backend
    ports:
      - "8080:8080"
    depends_on:
      - mysql
      - redis

  frontend:
    image: blog-frontend
    ports:
      - "80:80"
    depends_on:
      - backend

volumes:
  mysql_data:
```

### 传统部署

1. **后端部署**
```bash
# 打包
mvn clean package -DskipTests

# 运行
java -jar target/blog-backend-1.0.0.jar
```

2. **前端部署**
```bash
# 构建
npm run build

# 部署到nginx
cp -r dist/* /var/www/html/
```

## 🎨 界面预览

### 前台界面
- **首页** - 简洁的博客列表展示
- **文章详情** - 优雅的阅读体验
- **分类页** - 清晰的分类导航
- **关于页** - 个人信息展示

### 后台界面  
- **仪表盘** - 数据统计可视化
- **内容管理** - 便捷的管理界面
- **用户管理** - 完善的权限控制

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request 来改进这个项目！

1. Fork 此仓库
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开一个 Pull Request

## 📄 开源协议

本项目基于 [MIT License](https://opensource.org/licenses/MIT) 开源协议。

## 📞 联系方式

- **作者**: kangkangqing
- **邮箱**: sunhao@stu.cqie.edu.cn
- **GitHub**: https://github.com/kangkangqing/blog

## 🙏 致谢

感谢以下开源项目：
- [Spring Boot](https://spring.io/projects/spring-boot)
- [Vue.js](https://vuejs.org/)
- [Element Plus](https://element-plus.org/)
- [MyBatis-Plus](https://baomidou.com/)
- [Sa-Token](https://sa-token.cc/)

---

⭐ 如果这个项目对您有帮助，请给个星星支持一下！
- `POST /api/auth/login` - 用户登录
- `POST /api/auth/register` - 用户注册
- `GET /api/user/info` - 获取用户信息
- `PUT /api/user/info` - 更新用户信息

### 博客相关
- `GET /api/blogs` - 获取博客列表
- `GET /api/blogs/{id}` - 获取博客详情
- `POST /api/blogs` - 创建博客
- `PUT /api/blogs/{id}` - 更新博客
- `DELETE /api/blogs/{id}` - 删除博客
- `GET /api/blogs/search` - 搜索博客

### 分类相关
- `GET /api/categories` - 获取分类列表
- `POST /api/categories` - 创建分类
- `PUT /api/categories/{id}` - 更新分类
- `DELETE /api/categories/{id}` - 删除分类

### 评论相关
- `GET /api/comments/blog/{blogId}` - 获取博客评论
- `POST /api/comments` - 添加评论
- `DELETE /api/comments/{id}` - 删除评论

## 🛡️ 安全机制

- **JWT认证** - 无状态身份验证
- **密码加密** - MD5加盐加密
- **跨域处理** - CORS配置
- **参数校验** - 数据验证
- **SQL注入防护** - MyBatis-Plus预编译
- **XSS防护** - 前端过滤

## 📦 部署方案

### Docker 部署 (推荐)

```bash
# 构建并启动所有服务
docker-compose up -d

# 包含：MySQL、Redis、后端服务、前端服务
```

### 传统部署

```bash
# 后端打包
cd backend
mvn clean package

# 前端构建
cd frontend
npm run build

# 部署到服务器
# 1. 上传jar包到服务器
# 2. 上传前端dist目录到nginx
# 3. 配置nginx代理
```

## 📖 开发规范

### 后端规范
- **命名规范** - 驼峰命名法
- **包结构** - 按功能分层
- **代码注释** - 类和方法必须有注释
- **异常处理** - 统一异常处理机制
- **日志规范** - 使用SLF4J + Logback

### 前端规范
- **命名规范** - kebab-case (组件文件名)
- **组件开发** - 单文件组件 (.vue)
- **状态管理** - 使用Pinia管理全局状态
- **API调用** - 统一封装Axios
- **样式规范** - 使用SCSS，遵循BEM命名

## 🔄 版本控制

### Git 工作流
- **main** - 主分支，生产环境代码
- **develop** - 开发分支，集成最新功能
- **feature/** - 功能分支，开发新功能
- **hotfix/** - 热修复分支，紧急修复

### 提交规范
```
feat: 新功能
fix: 修复bug
docs: 文档更新
style: 代码格式化
refactor: 重构代码
test: 测试相关
chore: 构建工具或辅助工具的变动
```

## 🤝 贡献指南

1. **Fork 项目** 到你的 GitHub 账户
2. **创建功能分支** (`git checkout -b feature/AmazingFeature`)
3. **提交更改** (`git commit -m 'feat: Add some AmazingFeature'`)
4. **推送分支** (`git push origin feature/AmazingFeature`)
5. **创建 Pull Request**

## 📋 开发计划

### v1.0.0 (基础版本)
- [x] 项目初始化
- [ ] 后端基础框架搭建
- [ ] 数据库设计与创建
- [ ] 用户认证系统
- [ ] 博客CRUD功能
- [ ] 前端页面开发
- [ ] 基础部署方案

### v1.1.0 (功能增强)
- [ ] 评论系统
- [ ] 文章搜索
- [ ] 分类管理
- [ ] 文件上传
- [ ] 数据统计

### v1.2.0 (性能优化)
- [ ] Redis缓存优化
- [ ] 数据库性能优化
- [ ] 前端性能优化
- [ ] Docker容器化

## 📞 联系方式

如有问题或建议，请通过以下方式联系：

- **GitHub Issues**: [提交Issue](https://github.com/kangkangqing/blog/issues)
- **GitHub Discussions**: [参与讨论](https://github.com/kangkangqing/blog/discussions)
- **作者邮箱**: sunhao@stu.cqie.edu.cn
- **GitHub**: [@kangkangqing](https://github.com/kangkangqing)

## 📄 许可证

本项目采用 [MIT License](LICENSE) 开源许可证。

## 🙏 致谢

感谢以下开源项目：

- [Spring Boot](https://spring.io/projects/spring-boot)
- [MyBatis-Plus](https://mp.baomidou.com/)
- [Vue.js](https://vuejs.org/)
- [Element Plus](https://element-plus.org/)
- [Pinia](https://pinia.vuejs.org/)

---

⭐ 如果这个项目对你有帮助，请给一个 Star 支持一下！
