# 个人博客系统 (Personal Blog System)

## 📋 项目概述

这是一个基于 **Spring Boot + Vue3** 的前后端分离个人博客系统，采用现代化技术栈构建，支持文章发布、分类管理、评论互动等核心功能，适合个人开发者快速搭建专业的博客网站。

## 🛠️ 技术栈

### 后端技术栈
- **JDK 8** - Java开发环境
- **Spring Boot 2.7.x** - 主框架 (兼容JDK8)
- **MyBatis** - ORM框架
- **MyBatis-Plus** - MyBatis增强工具
- **MySQL 8.0** - 主数据库
- **Redis** - 缓存数据库
- **Spring Security + JWT** - 安全认证
- **Swagger** - API文档
- **Maven** - 项目构建工具

### 前端技术栈
- **Vue 3** - 前端框架
- **Element Plus** - UI组件库
- **Pinia** - 状态管理
- **Vue Router** - 路由管理
- **Axios** - HTTP客户端
- **Vite** - 构建工具

### 开发工具
- **VS Code** - 代码编辑器 (配置MCP)
- **Git** - 版本控制
- **Docker** - 容器化部署 (可选)

## 🏗️ 系统架构

```
┌─────────────────┐    HTTP/HTTPS    ┌─────────────────┐
│   Vue3 前端     │ ────────────────► │  Spring Boot    │
│   (端口:3000)   │                   │   后端服务      │
│                 │                   │  (端口:8080)    │
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

## 📁 项目结构

```
blog/
├── backend/                          # Spring Boot 后端
│   ├── src/main/java/com/blog/
│   │   ├── BlogApplication.java      # 启动类
│   │   ├── config/                   # 配置类
│   │   │   ├── SecurityConfig.java   # 安全配置
│   │   │   ├── RedisConfig.java      # Redis配置
│   │   │   ├── MyBatisPlusConfig.java# MyBatis-Plus配置
│   │   │   └── SwaggerConfig.java    # Swagger配置
│   │   ├── controller/               # 控制器层
│   │   │   ├── BlogController.java   # 博客控制器
│   │   │   ├── UserController.java   # 用户控制器
│   │   │   ├── CategoryController.java# 分类控制器
│   │   │   └── CommentController.java # 评论控制器
│   │   ├── service/                  # 服务层
│   │   │   ├── BlogService.java      # 博客服务
│   │   │   ├── UserService.java      # 用户服务
│   │   │   ├── CategoryService.java  # 分类服务
│   │   │   └── CommentService.java   # 评论服务
│   │   ├── mapper/                   # 数据访问层
│   │   │   ├── BlogMapper.java       # 博客Mapper
│   │   │   ├── UserMapper.java       # 用户Mapper
│   │   │   ├── CategoryMapper.java   # 分类Mapper
│   │   │   └── CommentMapper.java    # 评论Mapper
│   │   ├── entity/                   # 实体类
│   │   │   ├── Blog.java            # 博客实体
│   │   │   ├── User.java            # 用户实体
│   │   │   ├── Category.java        # 分类实体
│   │   │   └── Comment.java         # 评论实体
│   │   ├── dto/                     # 数据传输对象
│   │   ├── vo/                      # 视图对象
│   │   ├── utils/                   # 工具类
│   │   │   ├── JwtUtils.java        # JWT工具
│   │   │   ├── RedisUtils.java      # Redis工具
│   │   │   └── MD5Utils.java        # 加密工具
│   │   └── common/                  # 公共类
│   │       ├── Result.java          # 统一返回结果
│   │       └── Constants.java       # 常量类
│   ├── src/main/resources/
│   │   ├── application.yml          # 主配置文件
│   │   ├── application-dev.yml      # 开发环境配置
│   │   ├── application-prod.yml     # 生产环境配置
│   │   └── mapper/                  # MyBatis XML文件
│   └── pom.xml                      # Maven配置
│
├── frontend/                        # Vue3 前端
│   ├── src/
│   │   ├── components/              # 公共组件
│   │   │   ├── Header.vue           # 头部组件
│   │   │   ├── Footer.vue           # 底部组件
│   │   │   ├── Sidebar.vue          # 侧边栏组件
│   │   │   └── BlogCard.vue         # 博客卡片组件
│   │   ├── views/                   # 页面组件
│   │   │   ├── Home.vue             # 首页
│   │   │   ├── BlogList.vue         # 博客列表
│   │   │   ├── BlogDetail.vue       # 博客详情
│   │   │   ├── Category.vue         # 分类页面
│   │   │   ├── Login.vue            # 登录页面
│   │   │   └── Admin/               # 管理后台
│   │   │       ├── Dashboard.vue    # 仪表盘
│   │   │       ├── BlogManage.vue   # 博客管理
│   │   │       ├── CategoryManage.vue# 分类管理
│   │   │       └── CommentManage.vue # 评论管理
│   │   ├── router/                  # 路由配置
│   │   │   └── index.js             # 路由定义
│   │   ├── stores/                  # Pinia状态管理
│   │   │   ├── user.js              # 用户状态
│   │   │   ├── blog.js              # 博客状态
│   │   │   └── category.js          # 分类状态
│   │   ├── api/                     # API接口
│   │   │   ├── blog.js              # 博客API
│   │   │   ├── user.js              # 用户API
│   │   │   ├── category.js          # 分类API
│   │   │   └── comment.js           # 评论API
│   │   ├── utils/                   # 工具函数
│   │   │   ├── request.js           # Axios封装
│   │   │   ├── auth.js              # 认证工具
│   │   │   └── date.js              # 日期工具
│   │   ├── assets/                  # 静态资源
│   │   ├── styles/                  # 样式文件
│   │   ├── App.vue                  # 根组件
│   │   └── main.js                  # 入口文件
│   ├── package.json                 # npm配置
│   ├── vite.config.js              # Vite配置
│   └── index.html                   # HTML模板
│
├── docs/                           # 项目文档
│   ├── api.md                      # API文档
│   ├── database.sql                # 数据库脚本
│   └── deploy.md                   # 部署文档
├── .vscode/                        # VS Code配置
├── .gitignore                      # Git忽略文件
└── README.md                       # 项目说明
```


## 🚀 核心功能模块

### 用户端功能
- **首页展示** - 最新文章、热门文章、分类导航
- **文章浏览** - 文章列表、详情页、分页查询
- **分类筛选** - 按分类查看文章
- **文章搜索** - 关键词搜索文章内容
- **评论互动** - 文章评论、回复评论
- **用户注册/登录** - JWT身份认证

### 管理端功能
- **后台仪表盘** - 数据统计、图表展示
- **文章管理** - 文章发布、编辑、删除、草稿
- **分类管理** - 分类增删改查
- **评论管理** - 评论审核、删除
- **用户管理** - 用户信息管理
- **系统设置** - 站点配置、个人信息

## 🗄️ 数据库设计

### 主要数据表

#### 用户表 (t_user)
| 字段名 | 类型 | 说明 | 备注 |
|--------|------|------|------|
| id | bigint | 主键ID | 自增 |
| username | varchar(50) | 用户名 | 唯一 |
| password | varchar(100) | 密码 | MD5加密 |
| email | varchar(100) | 邮箱 | 唯一 |
| nickname | varchar(50) | 昵称 | |
| avatar | varchar(200) | 头像URL | |
| status | tinyint | 状态 | 0禁用 1启用 |
| create_time | datetime | 创建时间 | |
| update_time | datetime | 更新时间 | |

#### 博客表 (t_blog)
| 字段名 | 类型 | 说明 | 备注 |
|--------|------|------|------|
| id | bigint | 主键ID | 自增 |
| title | varchar(200) | 文章标题 | |
| content | longtext | 文章内容 | Markdown格式 |
| summary | varchar(500) | 文章摘要 | |
| cover_image | varchar(200) | 封面图片 | |
| category_id | bigint | 分类ID | 外键 |
| user_id | bigint | 作者ID | 外键 |
| view_count | int | 浏览次数 | 默认0 |
| like_count | int | 点赞次数 | 默认0 |
| status | tinyint | 状态 | 0草稿 1发布 |
| create_time | datetime | 创建时间 | |
| update_time | datetime | 更新时间 | |

#### 分类表 (t_category)
| 字段名 | 类型 | 说明 | 备注 |
|--------|------|------|------|
| id | bigint | 主键ID | 自增 |
| name | varchar(50) | 分类名称 | 唯一 |
| description | varchar(200) | 分类描述 | |
| sort | int | 排序 | 升序 |
| status | tinyint | 状态 | 0禁用 1启用 |
| create_time | datetime | 创建时间 | |
| update_time | datetime | 更新时间 | |

#### 评论表 (t_comment)
| 字段名 | 类型 | 说明 | 备注 |
|--------|------|------|------|
| id | bigint | 主键ID | 自增 |
| blog_id | bigint | 博客ID | 外键 |
| parent_id | bigint | 父评论ID | 0为顶级评论 |
| user_id | bigint | 评论用户ID | 外键 |
| content | text | 评论内容 | |
| status | tinyint | 状态 | 0待审核 1已审核 |
| create_time | datetime | 创建时间 | |

## 🔧 环境要求

### 开发环境
- **JDK 8** 或更高版本
- **Maven 3.6+** 
- **MySQL 8.0+**
- **Redis 5.0+**
- **Node.js 16+**
- **npm 或 yarn**

### 推荐开发工具
- **IntelliJ IDEA** (后端开发)
- **VS Code** (前端开发)
- **Navicat** (数据库管理)
- **Another Redis Desktop Manager** (Redis管理)

## 🏃‍♂️ 快速开始

### 1. 环境准备

```bash
# 克隆项目
git clone https://github.com/kangkangqing/blog.git
cd blog

# 创建数据库
mysql -u root -p
CREATE DATABASE blog_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# 导入数据库脚本
mysql -u root -p blog_db < docs/database.sql
```

### 2. 后端启动

```bash
cd backend

# 修改配置文件 src/main/resources/application-dev.yml
# 配置数据库连接信息和Redis连接信息

# 启动后端服务
mvn spring-boot:run

# 或者使用IDE启动 BlogApplication.java
```

### 3. 前端启动

```bash
cd frontend

# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

### 4. 访问应用

- **前端地址**: http://localhost:3000
- **后端API**: http://localhost:8080
- **API文档**: http://localhost:8080/swagger-ui/index.html
- **管理后台**: http://localhost:3000/admin

## 📡 API 接口设计

### 用户相关
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

## VS Code 开发配置

项目包含以下VS Code配置：
- `chat.mcp.discovery.enabled`: 启用MCP发现功能，提供AI辅助开发
- `chat.mcp.serverSampling`: MCP服务器采样配置
- `terminal.integrated.tabs.defaultIcon`: GitHub风格终端图标

## 部署

### Docker 部署
```bash
# 构建镜像
docker-compose build

# 启动服务
docker-compose up -d
```

### 传统部署
1. 后端打包：`mvn clean package`
2. 前端构建：`npm run build`
3. 部署到服务器

## API 文档

启动后端服务后，访问 Swagger UI 查看完整的API文档：
http://localhost:8080/swagger-ui.html

## 贡献指南

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 联系方式

如有问题或建议，请提交 Issue 或通过以下方式联系：

- GitHub: [@kangkangqing](https://github.com/kangkangqing)
- Email: sunhao@stu.cqie.edu.cn
