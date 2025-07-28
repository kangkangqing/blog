# 📚 博客系统 API 接口文档

## 🔧 基础信息

- **Base URL**: `http://localhost:8080/api`
- **认证方式**: Sa-Token (请求头: `satoken: {token}`)
- **数据格式**: JSON
- **字符编码**: UTF-8
- **API版本**: v1.0

## 📤 统一响应格式

所有API接口返回数据均遵循以下格式：

```json
{
  "code": 200,
  "message": "success",
  "data": {}
}
```

### 📊 响应状态码说明
| 状态码 | 说明 | 描述 |
|--------|------|------|
| `200` | 成功 | 请求处理成功 |
| `400` | 请求参数错误 | 客户端请求参数有误 |
| `401` | 未授权 | 用户未登录或token无效 |
| `403` | 权限不足 | 用户无权限访问该资源 |
| `404` | 资源不存在 | 请求的资源不存在 |
| `500` | 服务器内部错误 | 服务器处理出现异常 |

## 🔐 1. 用户认证模块

### 1.1 用户登录
**POST** `/auth/login`

**描述**: 用户登录获取访问令牌

**请求参数**:
```json
{
  "username": "admin",
  "password": "123456",
  "captchaKey": "uuid-key",
  "captcha": "abc123"
}
```

**响应示例**:
```json
{
  "code": 200,
  "message": "登录成功",
  "data": {
    "token": "abcd-efgh-1234-5678",
    "tokenTimeout": 86400,
    "userInfo": {
      "id": 1,
      "username": "admin",
      "nickname": "管理员",
      "email": "admin@example.com",
      "avatar": "http://example.com/avatar.jpg",
      "roles": ["admin"]
    }
  }
}
```

### 1.2 用户注册
**POST** `/auth/register`

**请求参数**:
```json
{
  "username": "testuser",
  "password": "123456",
  "email": "test@example.com",
  "nickname": "测试用户",
  "captchaKey": "uuid-key",
  "captcha": "abc123"
}
```

### 1.3 用户登出
**POST** `/auth/logout`

**请求头**: `satoken: {token}`

### 1.4 获取验证码
**GET** `/auth/captcha`

**响应示例**:
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "captchaKey": "uuid-1234-5678",
    "captchaImage": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA..."
  }
}
```

## 👤 2. 用户管理模块

### 2.1 获取用户信息
**GET** `/user/info`

**请求头**: `satoken: {token}`

**响应示例**:
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "id": 1,
    "username": "admin",
    "nickname": "管理员",
    "email": "admin@example.com",
    "avatar": "http://example.com/avatar.jpg",
    "status": 1,
    "createTime": "2024-01-01 10:00:00"
  }
}
```

### 2.2 更新用户信息
**PUT** `/user/info`

**请求参数**:
```json
{
  "nickname": "新昵称",
  "email": "new@example.com",
  "avatar": "http://example.com/new-avatar.jpg"
}
```

### 2.3 修改密码
**PUT** `/user/password`

**请求参数**:
```json
{
  "oldPassword": "123456",
  "newPassword": "654321",
  "confirmPassword": "654321"
}
```

## 📝 3. 博客文章模块

### 3.1 获取文章列表
**GET** `/articles`

**查询参数**:
- `page`: 页码 (默认: 1)
- `size`: 每页大小 (默认: 10)
- `categoryId`: 分类ID
- `tagId`: 标签ID
- `status`: 发布状态 (0-草稿, 1-已发布)
- `keyword`: 搜索关键词

**响应示例**:
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
        "title": "文章标题",
        "summary": "文章摘要",
        "coverImage": "http://example.com/cover.jpg",
        "viewCount": 100,
        "likeCount": 20,
        "commentCount": 5,
        "publishStatus": 1,
        "createTime": "2024-01-01 10:00:00",
        "category": {
          "id": 1,
          "name": "技术分享"
        },
        "tags": [
          {
            "id": 1,
            "name": "Spring Boot"
          }
        ]
      }
    ]
  }
}
```

### 3.2 获取文章详情
**GET** `/articles/{id}`

**路径参数**:
- `id`: 文章ID

### 3.3 创建文章
**POST** `/articles`

**请求参数**:
```json
{
  "title": "文章标题",
  "content": "文章内容",
  "summary": "文章摘要",
  "coverImage": "http://example.com/cover.jpg",
  "categoryId": 1,
  "tagIds": [1, 2, 3],
  "publishStatus": 1
}
```

### 3.4 更新文章
**PUT** `/articles/{id}`

### 3.5 删除文章
**DELETE** `/articles/{id}`

## 📁 4. 分类管理模块

### 4.1 获取分类列表
**GET** `/categories`

### 4.2 创建分类
**POST** `/categories`

**请求参数**:
```json
{
  "name": "分类名称",
  "description": "分类描述",
  "sortOrder": 1
}
```

### 4.3 更新分类
**PUT** `/categories/{id}`

### 4.4 删除分类
**DELETE** `/categories/{id}`

## 🏷️ 5. 标签管理模块

### 5.1 获取标签列表
**GET** `/tags`

### 5.2 创建标签
**POST** `/tags`

**请求参数**:
```json
{
  "name": "标签名称",
  "color": "#ff0000",
  "description": "标签描述"
}
```

## 💬 6. 评论管理模块

### 6.1 获取评论列表
**GET** `/comments`

**查询参数**:
- `articleId`: 文章ID
- `page`: 页码
- `size`: 每页大小

### 6.2 添加评论
**POST** `/comments`

**请求参数**:
```json
{
  "articleId": 1,
  "content": "评论内容",
  "parentId": null,
  "replyUserId": null
}
```

### 6.3 删除评论
**DELETE** `/comments/{id}`

## 📊 7. 统计分析模块

### 7.1 获取博客统计数据
**GET** `/statistics/blog`

**响应示例**:
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "totalArticles": 100,
    "totalComments": 500,
    "totalViews": 10000,
    "totalUsers": 50
  }
}
```

### 7.2 获取访问统计
**GET** `/statistics/access`

## 📁 8. 文件管理模块

### 8.1 文件上传
**POST** `/files/upload`

**请求参数**: multipart/form-data
- `file`: 文件

**响应示例**:
```json
{
  "code": 200,
  "message": "上传成功",
  "data": {
    "id": 1,
    "originalName": "image.jpg",
    "fileName": "uuid-image.jpg",
    "filePath": "/uploads/2024/01/uuid-image.jpg",
    "fileUrl": "http://example.com/uploads/2024/01/uuid-image.jpg",
    "fileSize": 1024000,
    "fileType": "image/jpeg"
  }
}
```

### 8.2 获取文件列表
**GET** `/files`

### 8.3 删除文件
**DELETE** `/files/{id}`

## ⚙️ 9. 系统配置模块

### 9.1 获取系统配置
**GET** `/config`

### 9.2 更新系统配置
**PUT** `/config`

**请求参数**:
```json
{
  "siteName": "我的博客",
  "siteDescription": "一个个人博客网站",
  "keywords": "博客,技术,分享",
  "icp": "京ICP备12345678号"
}
```

## 📝 接口调用示例

### JavaScript/Axios 示例

```javascript
// 设置全局请求拦截器
axios.defaults.baseURL = 'http://localhost:8080/api';
axios.interceptors.request.use(config => {
  const token = localStorage.getItem('satoken');
  if (token) {
    config.headers.satoken = token;
  }
  return config;
});

// 登录
const login = async (username, password) => {
  const response = await axios.post('/auth/login', {
    username,
    password
  });
  return response.data;
};

// 获取文章列表
const getArticles = async (page = 1, size = 10) => {
  const response = await axios.get('/articles', {
    params: { page, size }
  });
  return response.data;
};
```

### cURL 示例

```bash
# 登录
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"123456"}'

# 获取文章列表
curl -X GET "http://localhost:8080/api/articles?page=1&size=10" \
  -H "satoken: your-token-here"
```

## 🔍 在线API文档

项目启动后，可以通过以下地址访问交互式API文档：

- **Swagger UI**: `http://localhost:8080/swagger-ui.html`
- **API Docs**: `http://localhost:8080/v3/api-docs`

## 📞 技术支持

如有API使用问题，请参考：
1. 项目源码中的Controller层实现
2. 单元测试用例
3. 在线API文档
4. 项目README.md文档
