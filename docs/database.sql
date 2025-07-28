-- =====================================================
-- 博客系统完整数据库脚本
-- 版本: 3.0
-- 创建时间: 2024-01-01
-- 说明: 包含数据库创建、表结构、初始数据
-- =====================================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS `blog` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `blog`;

-- =====================================================
-- 用户模块表
-- =====================================================

-- 用户表
CREATE TABLE `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `password` VARCHAR(255) NOT NULL COMMENT '密码（加密后）',
    `email` VARCHAR(100) NOT NULL COMMENT '邮箱',
    `nickname` VARCHAR(50) NOT NULL COMMENT '昵称',
    `avatar` VARCHAR(500) DEFAULT NULL COMMENT '用户头像URL',
    `intro` VARCHAR(500) DEFAULT NULL COMMENT '个人简介',
    `website` VARCHAR(255) DEFAULT NULL COMMENT '个人网站',
    `status` TINYINT DEFAULT 1 COMMENT '状态：0-禁用 1-启用',
    `login_time` DATETIME DEFAULT NULL COMMENT '最后登录时间',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-未删除 1-已删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    UNIQUE KEY `uk_email` (`email`),
    KEY `idx_status` (`status`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- 角色表
CREATE TABLE `role` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '角色ID',
    `role_name` VARCHAR(50) NOT NULL COMMENT '角色名称',
    `role_key` VARCHAR(50) NOT NULL COMMENT '角色标识',
    `description` VARCHAR(200) DEFAULT NULL COMMENT '角色描述',
    `status` TINYINT DEFAULT 1 COMMENT '状态：0-禁用 1-启用',
    `sort_order` INT DEFAULT 0 COMMENT '排序',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-未删除 1-已删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_role_key` (`role_key`),
    KEY `idx_status` (`status`),
    KEY `idx_sort_order` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

-- 用户角色关联表
CREATE TABLE `user_role` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `role_id` BIGINT NOT NULL COMMENT '角色ID',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_role` (`user_id`,`role_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户角色关联表';

-- =====================================================
-- 博客模块表
-- =====================================================

-- 博客分类表
CREATE TABLE `blog_category` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `name` VARCHAR(100) NOT NULL COMMENT '分类名称',
    `description` VARCHAR(500) DEFAULT NULL COMMENT '分类描述',
    `icon` VARCHAR(100) DEFAULT NULL COMMENT '分类图标',
    `color` VARCHAR(20) DEFAULT NULL COMMENT '分类颜色',
    `sort_order` INT DEFAULT 0 COMMENT '排序号',
    `article_count` INT DEFAULT 0 COMMENT '文章数量',
    `enabled` TINYINT DEFAULT 1 COMMENT '是否启用',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name` (`name`),
    KEY `idx_sort_order` (`sort_order`),
    KEY `idx_enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='博客分类表';

-- 博客标签表
CREATE TABLE `blog_tag` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `name` VARCHAR(50) NOT NULL COMMENT '标签名称',
    `color` VARCHAR(20) DEFAULT NULL COMMENT '标签颜色',
    `article_count` INT DEFAULT 0 COMMENT '文章数量',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_name` (`name`),
    KEY `idx_article_count` (`article_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='博客标签表';

-- 博客文章表
CREATE TABLE `blog_article` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `title` VARCHAR(200) NOT NULL COMMENT '文章标题',
    `summary` VARCHAR(500) DEFAULT NULL COMMENT '文章摘要',
    `content` LONGTEXT NOT NULL COMMENT '文章内容',
    `cover_image` VARCHAR(500) DEFAULT NULL COMMENT '封面图片URL',
    `author_id` BIGINT NOT NULL COMMENT '作者ID',
    `category_id` BIGINT DEFAULT NULL COMMENT '分类ID',
    `tag_ids` VARCHAR(500) DEFAULT NULL COMMENT '标签IDs（JSON格式）',
    `is_top` TINYINT DEFAULT 0 COMMENT '是否置顶：0-否 1-是',
    `is_recommend` TINYINT DEFAULT 0 COMMENT '是否推荐：0-否 1-是',
    `is_original` TINYINT DEFAULT 1 COMMENT '是否原创：0-否 1-是',
    `status` TINYINT DEFAULT 1 COMMENT '状态：0-草稿 1-发布 2-私密',
    `view_count` INT DEFAULT 0 COMMENT '浏览量',
    `comment_count` INT DEFAULT 0 COMMENT '评论数量',
    `like_count` INT DEFAULT 0 COMMENT '点赞数量',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-未删除 1-已删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `publish_time` DATETIME DEFAULT NULL COMMENT '发布时间',
    PRIMARY KEY (`id`),
    KEY `idx_author_id` (`author_id`),
    KEY `idx_category_id` (`category_id`),
    KEY `idx_status` (`status`),
    KEY `idx_is_top` (`is_top`),
    KEY `idx_is_recommend` (`is_recommend`),
    KEY `idx_publish_time` (`publish_time`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='博客文章表';

-- 博客评论表
CREATE TABLE `blog_comment` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `article_id` BIGINT NOT NULL COMMENT '文章ID',
    `user_id` BIGINT DEFAULT NULL COMMENT '评论者ID（如果是注册用户）',
    `nickname` VARCHAR(50) NOT NULL COMMENT '评论者昵称',
    `email` VARCHAR(100) DEFAULT NULL COMMENT '评论者邮箱',
    `website` VARCHAR(255) DEFAULT NULL COMMENT '评论者网站',
    `avatar` VARCHAR(500) DEFAULT NULL COMMENT '评论者头像',
    `content` TEXT NOT NULL COMMENT '评论内容',
    `parent_id` BIGINT DEFAULT NULL COMMENT '父评论ID',
    `reply_user_id` BIGINT DEFAULT NULL COMMENT '回复用户ID',
    `reply_nickname` VARCHAR(50) DEFAULT NULL COMMENT '回复用户昵称',
    `ip_address` VARCHAR(45) DEFAULT NULL COMMENT 'IP地址',
    `user_agent` VARCHAR(500) DEFAULT NULL COMMENT '用户代理',
    `audit_status` TINYINT DEFAULT 1 COMMENT '审核状态：0-待审核 1-已通过 2-已拒绝',
    `like_count` INT DEFAULT 0 COMMENT '点赞数量',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_article_id` (`article_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_parent_id` (`parent_id`),
    KEY `idx_audit_status` (`audit_status`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='博客评论表';

-- =====================================================
-- 系统模块表
-- =====================================================

-- 文件信息表
CREATE TABLE `file_info` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `original_name` VARCHAR(255) NOT NULL COMMENT '原始文件名',
    `file_name` VARCHAR(255) NOT NULL COMMENT '存储文件名',
    `file_path` VARCHAR(500) NOT NULL COMMENT '文件路径',
    `file_url` VARCHAR(500) NOT NULL COMMENT '文件URL',
    `file_type` VARCHAR(100) DEFAULT NULL COMMENT '文件类型',
    `file_size` BIGINT DEFAULT NULL COMMENT '文件大小（字节）',
    `file_extension` VARCHAR(20) DEFAULT NULL COMMENT '文件扩展名',
    `file_purpose` VARCHAR(50) DEFAULT 'common' COMMENT '文件用途（avatar/cover/article/common）',
    `user_id` BIGINT DEFAULT NULL COMMENT '上传用户ID',
    `storage_type` VARCHAR(20) DEFAULT 'minio' COMMENT '存储类型（minio/local）',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_file_purpose` (`file_purpose`),
    KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件信息表';

-- 系统配置表
CREATE TABLE `system_config` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `config_key` VARCHAR(100) NOT NULL COMMENT '配置键',
    `config_value` TEXT DEFAULT NULL COMMENT '配置值',
    `config_group` VARCHAR(50) DEFAULT 'system' COMMENT '配置分组',
    `config_type` VARCHAR(20) DEFAULT 'string' COMMENT '配置类型（string/number/boolean/json）',
    `description` VARCHAR(200) DEFAULT NULL COMMENT '配置描述',
    `is_system` TINYINT DEFAULT 0 COMMENT '是否系统配置：0-否 1-是',
    `sort_order` INT DEFAULT 0 COMMENT '排序',
    `deleted` TINYINT DEFAULT 0 COMMENT '是否删除：0-未删除 1-已删除',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_config_key` (`config_key`),
    KEY `idx_config_group` (`config_group`),
    KEY `idx_sort_order` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';

-- 访问日志表
CREATE TABLE `access_log` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `ip_address` VARCHAR(45) NOT NULL COMMENT 'IP地址',
    `user_agent` VARCHAR(500) DEFAULT NULL COMMENT '用户代理',
    `request_url` VARCHAR(500) NOT NULL COMMENT '请求URL',
    `request_method` VARCHAR(10) DEFAULT NULL COMMENT '请求方法',
    `response_status` INT DEFAULT NULL COMMENT '响应状态码',
    `user_id` BIGINT DEFAULT NULL COMMENT '用户ID（如果已登录）',
    `session_id` VARCHAR(100) DEFAULT NULL COMMENT '会话ID',
    `referer` VARCHAR(500) DEFAULT NULL COMMENT '来源页面',
    `access_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '访问时间',
    PRIMARY KEY (`id`),
    KEY `idx_ip_address` (`ip_address`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_access_time` (`access_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='访问日志表';

-- =====================================================
-- 初始化数据
-- =====================================================

-- 初始化角色数据
INSERT INTO `role` (`role_name`, `role_key`, `description`, `status`, `sort_order`) VALUES
('超级管理员', 'admin', '拥有系统所有权限', 1, 1),
('普通用户', 'user', '普通注册用户', 1, 2),
('作者', 'author', '可以发布文章的用户', 1, 3);

-- 初始化管理员用户（密码：123456）
INSERT INTO `user` (`username`, `password`, `email`, `nickname`, `status`) VALUES
('admin', '$2a$10$7JB720yubVSOfvumdSNUNOyNrpU4d.T2/LOKmjYMwKI3YoOGQ1OLK', 'admin@example.com', '管理员', 1);

-- 关联管理员用户和角色
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES 
((SELECT id FROM `user` WHERE username = 'admin'), (SELECT id FROM `role` WHERE role_key = 'admin'));

-- 初始化博客分类
INSERT INTO `blog_category` (`name`, `description`, `icon`, `color`, `sort_order`, `enabled`) VALUES
('技术分享', '技术相关的文章', 'fa-code', '#409EFF', 1, 1),
('生活随笔', '生活感悟和随笔', 'fa-heart', '#67C23A', 2, 1),
('学习笔记', '学习过程中的笔记', 'fa-book', '#E6A23C', 3, 1),
('项目实战', '项目开发经验分享', 'fa-rocket', '#F56C6C', 4, 1);

-- 初始化博客标签
INSERT INTO `blog_tag` (`name`, `color`) VALUES
('Java', '#f56565'),
('Spring Boot', '#48bb78'),
('Vue.js', '#4299e1'),
('MySQL', '#ed8936'),
('Redis', '#9f7aea'),
('前端', '#38b2ac'),
('后端', '#d69e2e'),
('全栈', '#805ad5');

-- 初始化系统配置
INSERT INTO `system_config` (`config_key`, `config_value`, `config_group`, `config_type`, `description`, `is_system`, `sort_order`) VALUES
('site.title', '我的博客', 'site', 'string', '网站标题', 1, 1),
('site.description', '一个简洁的个人博客系统', 'site', 'string', '网站描述', 1, 2),
('site.keywords', '博客,技术,分享', 'site', 'string', '网站关键词', 1, 3),
('site.author', 'admin', 'site', 'string', '网站作者', 1, 4),
('site.icp', '', 'site', 'string', 'ICP备案号', 1, 5),
('upload.max_size', '10485760', 'upload', 'number', '文件上传最大大小（字节）', 1, 6),
('upload.allowed_types', 'jpg,jpeg,png,gif,pdf,doc,docx', 'upload', 'string', '允许上传的文件类型', 1, 7),
('comment.audit', '0', 'comment', 'boolean', '评论是否需要审核', 1, 8),
('comment.guest_comment', '1', 'comment', 'boolean', '是否允许游客评论', 1, 9);

-- 初始化示例文章
INSERT INTO `blog_article` (`title`, `summary`, `content`, `author_id`, `category_id`, `tag_ids`, `status`, `view_count`, `publish_time`) VALUES
('欢迎使用博客系统', '这是一篇示例文章，介绍了博客系统的基本功能。', 
'# 欢迎使用博客系统

这是一个基于Spring Boot + Vue.js开发的个人博客系统。

## 主要功能

- 用户管理
- 文章发布
- 分类标签
- 评论系统
- 文件上传

感谢使用！', 
(SELECT id FROM `user` WHERE username = 'admin'), 
(SELECT id FROM `blog_category` WHERE name = '技术分享'), 
'[1,2]', 1, 0, NOW());

-- 完成初始化
-- =====================================================
-- 数据库初始化完成
-- =====================================================
