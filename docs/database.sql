# 数据库设计文档

## 数据库创建脚本

```sql
-- 创建数据库
CREATE DATABASE IF NOT EXISTS blog_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE blog_db;

-- 用户表
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码(MD5加密)',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(200) DEFAULT NULL COMMENT '头像URL',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(0:禁用 1:启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  UNIQUE KEY `uk_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- 分类表
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `description` varchar(200) DEFAULT NULL COMMENT '分类描述',
  `sort` int(11) DEFAULT '0' COMMENT '排序(升序)',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(0:禁用 1:启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分类表';

-- 博客表
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(200) NOT NULL COMMENT '文章标题',
  `content` longtext NOT NULL COMMENT '文章内容(Markdown格式)',
  `summary` varchar(500) DEFAULT NULL COMMENT '文章摘要',
  `cover_image` varchar(200) DEFAULT NULL COMMENT '封面图片URL',
  `category_id` bigint(20) NOT NULL COMMENT '分类ID',
  `user_id` bigint(20) NOT NULL COMMENT '作者ID',
  `view_count` int(11) DEFAULT '0' COMMENT '浏览次数',
  `like_count` int(11) DEFAULT '0' COMMENT '点赞次数',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态(0:草稿 1:发布)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_create_time` (`create_time`),
  CONSTRAINT `fk_blog_category` FOREIGN KEY (`category_id`) REFERENCES `t_category` (`id`),
  CONSTRAINT `fk_blog_user` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='博客表';

-- 评论表
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `blog_id` bigint(20) NOT NULL COMMENT '博客ID',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父评论ID(0为顶级评论)',
  `user_id` bigint(20) NOT NULL COMMENT '评论用户ID',
  `content` text NOT NULL COMMENT '评论内容',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(0:待审核 1:已审核)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_blog_id` (`blog_id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_create_time` (`create_time`),
  CONSTRAINT `fk_comment_blog` FOREIGN KEY (`blog_id`) REFERENCES `t_blog` (`id`),
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';

-- 插入初始数据

-- 插入管理员用户
INSERT INTO `t_user` (`username`, `password`, `email`, `nickname`, `status`) VALUES
('admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin@blog.com', '管理员', 1);

-- 插入默认分类
INSERT INTO `t_category` (`name`, `description`, `sort`) VALUES
('技术分享', '分享技术相关的文章', 1),
('生活随笔', '记录生活中的点点滴滴', 2),
('学习笔记', '学习过程中的笔记和心得', 3),
('项目总结', '项目开发经验和总结', 4);

-- 插入示例博客
INSERT INTO `t_blog` (`title`, `content`, `summary`, `category_id`, `user_id`, `status`) VALUES
('欢迎来到我的博客', '# 欢迎来到我的博客\n\n这是第一篇博客文章，欢迎大家关注！', '这是第一篇博客文章，欢迎大家关注！', 2, 1, 1),
('Spring Boot 学习笔记', '# Spring Boot 学习笔记\n\n## 什么是Spring Boot\n\nSpring Boot是...', 'Spring Boot学习笔记，包含基础知识和实践经验', 3, 1, 1);
```

## 表关系说明

### 外键关系
- `t_blog.category_id` → `t_category.id` (博客-分类关系)
- `t_blog.user_id` → `t_user.id` (博客-用户关系)
- `t_comment.blog_id` → `t_blog.id` (评论-博客关系)
- `t_comment.user_id` → `t_user.id` (评论-用户关系)

### 索引说明
- **主键索引**: 每张表的 `id` 字段
- **唯一索引**: 用户名、邮箱、分类名称
- **普通索引**: 外键字段、状态字段、时间字段

### 字段说明

#### 状态字段
- **用户状态**: 0=禁用, 1=启用
- **博客状态**: 0=草稿, 1=发布
- **分类状态**: 0=禁用, 1=启用
- **评论状态**: 0=待审核, 1=已审核

#### 时间字段
- **create_time**: 创建时间，默认当前时间
- **update_time**: 更新时间，自动更新

## 性能优化建议

### 索引优化
```sql
-- 博客表常用查询索引
CREATE INDEX idx_blog_status_time ON t_blog(status, create_time DESC);
CREATE INDEX idx_blog_category_status ON t_blog(category_id, status);

-- 评论表查询索引
CREATE INDEX idx_comment_blog_status ON t_comment(blog_id, status);
```

### 分表建议
当数据量达到百万级别时，可以考虑以下分表策略：
- **博客表**: 按年份分表 (t_blog_2024, t_blog_2025)
- **评论表**: 按月份分表 (t_comment_202401, t_comment_202402)

### 缓存策略
- **热门文章**: Redis缓存，TTL 1小时
- **分类列表**: Redis缓存，TTL 24小时  
- **用户信息**: Redis缓存，TTL 30分钟
