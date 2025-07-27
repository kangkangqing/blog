# API 接口文档

## 基础信息

- **Base URL**: `http://localhost:8080/api`
- **认证方式**: JWT Token (请求头: `Authorization: Bearer {token}`)
- **数据格式**: JSON
- **字符编码**: UTF-8

## 统一响应格式

```json
{
  "code": 200,
  "message": "success",
  "data": {}
}
```

### 响应状态码
- `200`: 成功
- `400`: 请求参数错误
- `401`: 未授权
- `403`: 权限不足
- `404`: 资源不存在
- `500`: 服务器内部错误

## 1. 用户认证相关

### 1.1 用户登录
**POST** `/auth/login`

**请求参数:**
```json
{
  "username": "admin",
  "password": "123456"
}
```

**响应示例:**
```json
{
  "code": 200,
  "message": "登录成功",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiJ9...",
    "userInfo": {
      "id": 1,
      "username": "admin",
      "nickname": "管理员",
      "email": "admin@blog.com",
      "avatar": "http://..."
    }
  }
}
```

### 1.2 用户注册
**POST** `/auth/register`

**请求参数:**
```json
{
  "username": "testuser",
  "password": "123456",
  "email": "test@example.com",
  "nickname": "测试用户"
}
```

### 1.3 获取用户信息
**GET** `/user/info`

**请求头:**
```
Authorization: Bearer {token}
```

**响应示例:**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "id": 1,
    "username": "admin",
    "nickname": "管理员",
    "email": "admin@blog.com",
    "avatar": "http://...",
    "createTime": "2024-01-01 12:00:00"
  }
}
```

### 1.4 更新用户信息
**PUT** `/user/info`

**请求参数:**
```json
{
  "nickname": "新昵称",
  "email": "newemail@example.com",
  "avatar": "http://..."
}
```

## 2. 博客文章相关

### 2.1 获取博客列表
**GET** `/blogs`

**查询参数:**
- `page`: 页码 (默认: 1)
- `size`: 每页数量 (默认: 10)
- `categoryId`: 分类ID (可选)
- `keyword`: 搜索关键词 (可选)
- `status`: 状态 (可选, 1=已发布)

**示例:** `/blogs?page=1&size=10&categoryId=1&keyword=Spring`

**响应示例:**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "total": 100,
    "pages": 10,
    "current": 1,
    "size": 10,
    "records": [
      {
        "id": 1,
        "title": "Spring Boot 学习笔记",
        "summary": "Spring Boot学习笔记，包含基础知识...",
        "coverImage": "http://...",
        "categoryId": 1,
        "categoryName": "技术分享",
        "userId": 1,
        "authorName": "管理员",
        "viewCount": 100,
        "likeCount": 10,
        "status": 1,
        "createTime": "2024-01-01 12:00:00"
      }
    ]
  }
}
```

### 2.2 获取博客详情
**GET** `/blogs/{id}`

**响应示例:**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "id": 1,
    "title": "Spring Boot 学习笔记",
    "content": "# Spring Boot 学习笔记\n\n内容...",
    "summary": "Spring Boot学习笔记...",
    "coverImage": "http://...",
    "categoryId": 1,
    "categoryName": "技术分享",
    "userId": 1,
    "authorName": "管理员",
    "viewCount": 100,
    "likeCount": 10,
    "status": 1,
    "createTime": "2024-01-01 12:00:00",
    "updateTime": "2024-01-01 12:00:00"
  }
}
```

### 2.3 创建博客
**POST** `/blogs`

**请求头:** `Authorization: Bearer {token}`

**请求参数:**
```json
{
  "title": "新博客标题",
  "content": "# 博客内容\n\nMarkdown格式内容...",
  "summary": "博客摘要",
  "coverImage": "http://...",
  "categoryId": 1,
  "status": 1
}
```

### 2.4 更新博客
**PUT** `/blogs/{id}`

**请求头:** `Authorization: Bearer {token}`

**请求参数:** (同创建博客)

### 2.5 删除博客
**DELETE** `/blogs/{id}`

**请求头:** `Authorization: Bearer {token}`

### 2.6 博客搜索
**GET** `/blogs/search`

**查询参数:**
- `keyword`: 搜索关键词 (必填)
- `page`: 页码 (默认: 1)
- `size`: 每页数量 (默认: 10)

## 3. 分类管理

### 3.1 获取分类列表
**GET** `/categories`

**查询参数:**
- `status`: 状态 (可选, 1=启用)

**响应示例:**
```json
{
  "code": 200,
  "message": "success",
  "data": [
    {
      "id": 1,
      "name": "技术分享",
      "description": "分享技术相关的文章",
      "sort": 1,
      "status": 1,
      "blogCount": 10,
      "createTime": "2024-01-01 12:00:00"
    }
  ]
}
```

### 3.2 创建分类
**POST** `/categories`

**请求头:** `Authorization: Bearer {token}`

**请求参数:**
```json
{
  "name": "新分类",
  "description": "分类描述",
  "sort": 1
}
```

### 3.3 更新分类
**PUT** `/categories/{id}`

**请求头:** `Authorization: Bearer {token}`

**请求参数:** (同创建分类)

### 3.4 删除分类
**DELETE** `/categories/{id}`

**请求头:** `Authorization: Bearer {token}`

## 4. 评论管理

### 4.1 获取博客评论
**GET** `/comments/blog/{blogId}`

**查询参数:**
- `page`: 页码 (默认: 1)
- `size`: 每页数量 (默认: 10)

**响应示例:**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "total": 10,
    "records": [
      {
        "id": 1,
        "blogId": 1,
        "parentId": 0,
        "userId": 1,
        "userName": "用户名",
        "userAvatar": "http://...",
        "content": "评论内容",
        "status": 1,
        "createTime": "2024-01-01 12:00:00",
        "replies": [
          {
            "id": 2,
            "parentId": 1,
            "userId": 2,
            "userName": "回复用户",
            "content": "回复内容",
            "createTime": "2024-01-01 12:05:00"
          }
        ]
      }
    ]
  }
}
```

### 4.2 添加评论
**POST** `/comments`

**请求头:** `Authorization: Bearer {token}`

**请求参数:**
```json
{
  "blogId": 1,
  "parentId": 0,
  "content": "评论内容"
}
```

### 4.3 删除评论
**DELETE** `/comments/{id}`

**请求头:** `Authorization: Bearer {token}`

## 5. 文件上传

### 5.1 上传图片
**POST** `/upload/image`

**请求头:** `Authorization: Bearer {token}`

**请求参数:** FormData
- `file`: 图片文件 (jpg, png, gif, 最大5MB)

**响应示例:**
```json
{
  "code": 200,
  "message": "上传成功",
  "data": {
    "url": "http://localhost:8080/upload/images/20240101/abc123.jpg",
    "name": "abc123.jpg",
    "size": 102400
  }
}
```

## 6. 统计信息

### 6.1 获取统计数据
**GET** `/statistics/dashboard`

**请求头:** `Authorization: Bearer {token}`

**响应示例:**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "blogCount": 100,
    "categoryCount": 5,
    "commentCount": 200,
    "viewCount": 10000,
    "todayViewCount": 100,
    "recentBlogs": [],
    "recentComments": []
  }
}
```

## 错误码说明

| 错误码 | 说明 |
|--------|------|
| 10001 | 用户名或密码错误 |
| 10002 | 用户名已存在 |
| 10003 | 邮箱已存在 |
| 10004 | Token无效或已过期 |
| 20001 | 博客不存在 |
| 20002 | 无权限操作此博客 |
| 30001 | 分类不存在 |
| 30002 | 分类下还有博客，无法删除 |
| 40001 | 评论不存在 |
| 50001 | 文件上传失败 |
| 50002 | 文件格式不支持 |
| 50003 | 文件大小超出限制 |
