# 个人博客系统数据库设计文档

## 系统功能说明

### 前台功能
- **首页** - 最新文章、热门文章、推荐文章
- **分类页** - 按分类浏览文章
- **标签页** - 按标签筛选文章
- **时间线归档** - 按时间线浏览历史文章
- **关于页面** - 个人介绍和联系方式

### 后台功能
- **仪表盘** - 系统运行数据、访问统计图表
- **用户管理** - 用户信息管理
- **博客管理** - 文章发布、编辑、删除
- **分类管理** - 分类增删改查
- **标签管理** - 标签增删改查
- **系统信息** - 服务器运行状态监控

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
  `intro` varchar(500) DEFAULT NULL COMMENT '个人简介',
  `website` varchar(100) DEFAULT NULL COMMENT '个人网站',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(0:禁用 1:启用)',
  `login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
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
  `cover_image` varchar(200) DEFAULT NULL COMMENT '分类封面图',
  `sort` int(11) DEFAULT '0' COMMENT '排序(升序)',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(0:禁用 1:启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `idx_sort` (`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分类表';

-- 标签表
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) NOT NULL COMMENT '标签名称',
  `color` varchar(20) DEFAULT '#409EFF' COMMENT '标签颜色',
  `description` varchar(200) DEFAULT NULL COMMENT '标签描述',
  `sort` int(11) DEFAULT '0' COMMENT '排序(升序)',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(0:禁用 1:启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `idx_sort` (`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='标签表';

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
  `comment_count` int(11) DEFAULT '0' COMMENT '评论次数',
  `is_top` tinyint(4) DEFAULT '0' COMMENT '是否置顶(0:否 1:是)',
  `is_recommend` tinyint(4) DEFAULT '0' COMMENT '是否推荐(0:否 1:是)',
  `is_original` tinyint(4) DEFAULT '1' COMMENT '是否原创(0:转载 1:原创)',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态(0:草稿 1:发布 2:私密)',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_publish_time` (`publish_time`),
  KEY `idx_is_top` (`is_top`),
  KEY `idx_is_recommend` (`is_recommend`),
  KEY `idx_view_count` (`view_count`),
  CONSTRAINT `fk_blog_category` FOREIGN KEY (`category_id`) REFERENCES `t_category` (`id`),
  CONSTRAINT `fk_blog_user` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='博客表';

-- 博客标签关联表
DROP TABLE IF EXISTS `t_blog_tag`;
CREATE TABLE `t_blog_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `blog_id` bigint(20) NOT NULL COMMENT '博客ID',
  `tag_id` bigint(20) NOT NULL COMMENT '标签ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_blog_tag` (`blog_id`,`tag_id`),
  KEY `idx_blog_id` (`blog_id`),
  KEY `idx_tag_id` (`tag_id`),
  CONSTRAINT `fk_blog_tag_blog` FOREIGN KEY (`blog_id`) REFERENCES `t_blog` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_blog_tag_tag` FOREIGN KEY (`tag_id`) REFERENCES `t_tag` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='博客标签关联表';

-- 评论表
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `blog_id` bigint(20) NOT NULL COMMENT '博客ID',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父评论ID(0为顶级评论)',
  `user_id` bigint(20) DEFAULT NULL COMMENT '评论用户ID(null为游客)',
  `nickname` varchar(50) NOT NULL COMMENT '评论者昵称',
  `email` varchar(100) DEFAULT NULL COMMENT '评论者邮箱',
  `website` varchar(100) DEFAULT NULL COMMENT '评论者网站',
  `avatar` varchar(200) DEFAULT NULL COMMENT '评论者头像',
  `content` text NOT NULL COMMENT '评论内容',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `address` varchar(100) DEFAULT NULL COMMENT 'IP归属地',
  `device` varchar(100) DEFAULT NULL COMMENT '设备信息',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(0:待审核 1:已审核 2:已删除)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_blog_id` (`blog_id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_create_time` (`create_time`),
  CONSTRAINT `fk_comment_blog` FOREIGN KEY (`blog_id`) REFERENCES `t_blog` (`id`),
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='评论表';

-- 访问日志表
DROP TABLE IF EXISTS `t_visit_log`;
CREATE TABLE `t_visit_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID(游客为null)',
  `ip` varchar(50) NOT NULL COMMENT 'IP地址',
  `address` varchar(100) DEFAULT NULL COMMENT 'IP归属地',
  `user_agent` text DEFAULT NULL COMMENT '用户代理',
  `device` varchar(100) DEFAULT NULL COMMENT '设备类型',
  `os` varchar(100) DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(100) DEFAULT NULL COMMENT '浏览器',
  `referer` varchar(500) DEFAULT NULL COMMENT '来源页面',
  `url` varchar(500) NOT NULL COMMENT '访问页面',
  `method` varchar(10) NOT NULL COMMENT '请求方法',
  `params` text DEFAULT NULL COMMENT '请求参数',
  `time` int(11) DEFAULT NULL COMMENT '响应时间(毫秒)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '访问时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_ip` (`ip`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_url` (`url`(255))
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='访问日志表';

-- 系统配置表
DROP TABLE IF EXISTS `t_config`;
CREATE TABLE `t_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `config_key` varchar(100) NOT NULL COMMENT '配置键',
  `config_value` text DEFAULT NULL COMMENT '配置值',
  `config_type` varchar(20) DEFAULT 'string' COMMENT '配置类型(string,number,boolean,json)',
  `description` varchar(200) DEFAULT NULL COMMENT '配置描述',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_config_key` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';

-- 友链表
DROP TABLE IF EXISTS `t_friend_link`;
CREATE TABLE `t_friend_link` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) NOT NULL COMMENT '链接名称',
  `url` varchar(200) NOT NULL COMMENT '链接地址',
  `avatar` varchar(200) DEFAULT NULL COMMENT '头像',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(0:禁用 1:启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_sort` (`sort`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='友链表';

-- 插入初始数据

-- 插入管理员用户
INSERT INTO `t_user` (`username`, `password`, `email`, `nickname`, `intro`, `status`) VALUES
('admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin@blog.com', '博主', '一个热爱技术分享的程序员', 1);

-- 插入默认分类
INSERT INTO `t_category` (`name`, `description`, `sort`) VALUES
('技术分享', '分享技术相关的文章和经验', 1),
('生活随笔', '记录生活中的点点滴滴', 2),
('学习笔记', '学习过程中的笔记和心得体会', 3),
('项目总结', '项目开发经验和总结反思', 4),
('开源项目', '开源项目介绍和使用指南', 5);

-- 插入默认标签
INSERT INTO `t_tag` (`name`, `color`, `description`, `sort`) VALUES
('Java', '#f56c6c', 'Java编程语言相关', 1),
('Spring Boot', '#409eff', 'Spring Boot框架相关', 2),
('Vue', '#67c23a', 'Vue.js前端框架相关', 3),
('MySQL', '#e6a23c', 'MySQL数据库相关', 4),
('Redis', '#f56c6c', 'Redis缓存相关', 5),
('Docker', '#409eff', 'Docker容器技术相关', 6),
('Linux', '#67c23a', 'Linux系统相关', 7),
('算法', '#e6a23c', '算法与数据结构', 8),
('前端', '#f56c6c', '前端开发相关', 9),
('后端', '#409eff', '后端开发相关', 10);

-- 插入示例博客
INSERT INTO `t_blog` (`title`, `content`, `summary`, `category_id`, `user_id`, `is_recommend`, `status`, `publish_time`) VALUES
('欢迎来到我的博客', '# 欢迎来到我的博客\n\n这是我的第一篇博客文章，在这里我会分享技术学习心得、生活感悟和项目经验。\n\n## 博客内容\n\n- 技术分享\n- 学习笔记 \n- 生活随笔\n- 项目总结\n\n希望我的分享能对大家有所帮助！', '这是我的第一篇博客文章，欢迎大家关注和交流！', 2, 1, 1, 1, NOW()),
('Spring Boot 学习笔记', '# Spring Boot 学习笔记\n\n## 什么是Spring Boot\n\nSpring Boot是由Pivotal团队提供的全新框架，其设计目的是用来简化新Spring应用的初始搭建以及开发过程。\n\n## 主要特性\n\n1. 创建独立的Spring应用程序\n2. 嵌入的Tomcat，无需部署WAR文件\n3. 简化Maven配置\n4. 自动配置Spring\n5. 提供生产就绪型功能\n6. 绝对没有代码生成和对XML没有要求配置\n\n## 快速开始\n\n```java\n@SpringBootApplication\npublic class Application {\n    public static void main(String[] args) {\n        SpringApplication.run(Application.class, args);\n    }\n}\n```', 'Spring Boot学习笔记，包含基础知识和实践经验分享', 3, 1, 1, 1, NOW()),
('Vue3 + Element Plus 开发心得', '# Vue3 + Element Plus 开发心得\n\n## 项目搭建\n\n使用Vite快速搭建Vue3项目：\n\n```bash\nnpm create vue@latest my-project\ncd my-project\nnpm install\nnpm run dev\n```\n\n## Element Plus集成\n\n```bash\nnpm install element-plus\n```\n\n## 组合式API\n\nVue3的组合式API让代码组织更加灵活。', 'Vue3和Element Plus开发经验分享', 1, 1, 0, 1, NOW());

-- 插入博客标签关联
INSERT INTO `t_blog_tag` (`blog_id`, `tag_id`) VALUES
(2, 1), (2, 2), -- Spring Boot文章关联Java和Spring Boot标签
(3, 3), (3, 9); -- Vue3文章关联Vue和前端标签

-- 插入系统配置
INSERT INTO `t_config` (`config_key`, `config_value`, `config_type`, `description`) VALUES
('site_name', '个人博客系统', 'string', '网站名称'),
('site_description', '一个基于Spring Boot + Vue3的个人博客系统', 'string', '网站描述'),
('site_keywords', 'Java,Spring Boot,Vue,博客,技术分享', 'string', '网站关键词'),
('site_author', '博主', 'string', '网站作者'),
('site_record', '', 'string', '备案号'),
('site_create_time', '2024-01-01', 'string', '网站创建时间'),
('site_notice', '欢迎来到我的博客！', 'string', '网站公告'),
('comment_audit', 'false', 'boolean', '评论是否需要审核'),
('allow_comment', 'true', 'boolean', '是否允许评论'),
('email_notice', 'false', 'boolean', '是否开启邮件通知'),
('about_content', '# 关于我\n\n一个热爱技术分享的程序员。', 'string', '关于页面内容');

-- 插入友链示例
INSERT INTO `t_friend_link` (`name`, `url`, `description`, `sort`, `status`) VALUES
('GitHub', 'https://github.com', '全球最大的代码托管平台', 1, 1),
('Vue.js', 'https://vuejs.org', '渐进式JavaScript框架', 2, 1),
('Spring Boot', 'https://spring.io/projects/spring-boot', 'Java企业级应用框架', 3, 1);
```

## 表关系说明

### 外键关系
- `t_blog.category_id` → `t_category.id` (博客-分类关系)
- `t_blog.user_id` → `t_user.id` (博客-用户关系)
- `t_blog_tag.blog_id` → `t_blog.id` (博客标签-博客关系)
- `t_blog_tag.tag_id` → `t_tag.id` (博客标签-标签关系)
- `t_comment.blog_id` → `t_blog.id` (评论-博客关系)
- `t_comment.user_id` → `t_user.id` (评论-用户关系)
- `t_visit_log.user_id` → `t_user.id` (访问日志-用户关系)

### 多对多关系
- 博客和标签：通过 `t_blog_tag` 中间表实现多对多关系

### 索引说明
- **主键索引**: 每张表的 `id` 字段
- **唯一索引**: 用户名、邮箱、分类名称、标签名称、配置键
- **普通索引**: 外键字段、状态字段、时间字段、排序字段
- **复合索引**: blog_id+tag_id (博客标签关联表)

### 字段说明

#### 状态字段
- **用户状态**: 0=禁用, 1=启用
- **博客状态**: 0=草稿, 1=发布, 2=私密
- **分类状态**: 0=禁用, 1=启用
- **标签状态**: 0=禁用, 1=启用
- **评论状态**: 0=待审核, 1=已审核, 2=已删除
- **友链状态**: 0=禁用, 1=启用

#### 博客扩展字段
- **is_top**: 是否置顶
- **is_recommend**: 是否推荐
- **is_original**: 是否原创
- **publish_time**: 发布时间(用于时间线归档)
- **comment_count**: 评论数量(冗余字段，提高查询性能)

#### 评论扩展字段
- **支持游客评论**: user_id可为null
- **IP地址和归属地**: 用于统计分析
- **设备信息**: 用于访问统计

#### 访问日志字段
- **详细的用户代理信息**: 设备、操作系统、浏览器
- **访问路径和参数**: 用于分析用户行为
- **响应时间**: 用于性能监控

## 数据统计查询示例

### 1. 首页统计数据
```sql
-- 文章总数
SELECT COUNT(*) FROM t_blog WHERE status = 1;

-- 分类总数
SELECT COUNT(*) FROM t_category WHERE status = 1;

-- 标签总数
SELECT COUNT(*) FROM t_tag WHERE status = 1;

-- 总访问量
SELECT SUM(view_count) FROM t_blog;

-- 今日访问量
SELECT COUNT(*) FROM t_visit_log WHERE DATE(create_time) = CURDATE();
```

### 2. 时间线归档数据
```sql
-- 按年月统计文章数量
SELECT 
    DATE_FORMAT(publish_time, '%Y年%m月') as month,
    COUNT(*) as count
FROM t_blog 
WHERE status = 1 
GROUP BY DATE_FORMAT(publish_time, '%Y-%m')
ORDER BY month DESC;
```

### 3. 热门文章统计
```sql
-- 浏览量最高的文章
SELECT id, title, view_count 
FROM t_blog 
WHERE status = 1 
ORDER BY view_count DESC 
LIMIT 10;
```

### 4. 标签使用统计
```sql
-- 标签使用频率
SELECT 
    t.name, 
    t.color,
    COUNT(bt.blog_id) as blog_count
FROM t_tag t
LEFT JOIN t_blog_tag bt ON t.id = bt.tag_id
LEFT JOIN t_blog b ON bt.blog_id = b.id AND b.status = 1
WHERE t.status = 1
GROUP BY t.id, t.name, t.color
ORDER BY blog_count DESC;
```

## 性能优化建议

### 索引优化
```sql
-- 博客表复合索引
CREATE INDEX idx_blog_status_publish_time ON t_blog(status, publish_time DESC);
CREATE INDEX idx_blog_category_status ON t_blog(category_id, status);
CREATE INDEX idx_blog_recommend_status ON t_blog(is_recommend, status);
CREATE INDEX idx_blog_top_status ON t_blog(is_top, status, publish_time DESC);

-- 评论表索引
CREATE INDEX idx_comment_blog_status ON t_comment(blog_id, status);

-- 访问日志表索引
CREATE INDEX idx_visit_log_date ON t_visit_log(DATE(create_time));
CREATE INDEX idx_visit_log_ip_date ON t_visit_log(ip, DATE(create_time));

-- 博客标签关联表索引已在建表时创建
```

### 分表建议
当数据量达到一定规模时：
- **访问日志表**: 按月份分表 (t_visit_log_202401, t_visit_log_202402)
- **评论表**: 按年份分表 (t_comment_2024, t_comment_2025)
- **博客表**: 一般不需要分表，通过索引优化即可

### 缓存策略
- **热门文章**: Redis缓存，TTL 1小时
- **分类列表**: Redis缓存，TTL 24小时  
- **标签列表**: Redis缓存，TTL 24小时
- **系统配置**: Redis缓存，TTL 24小时
- **友链列表**: Redis缓存，TTL 24小时
- **今日访问量**: Redis计数器，TTL到当天结束

### 数据库连接池配置建议
```yaml
spring:
  datasource:
    hikari:
      minimum-idle: 5
      maximum-pool-size: 20
      idle-timeout: 300000
      connection-timeout: 20000
      max-lifetime: 1200000
```
