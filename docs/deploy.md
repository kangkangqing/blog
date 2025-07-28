# 🚀 博客系统部署指南

## 📋 环境要求

### 开发环境
- **JDK**: 1.8+ (推荐 OpenJDK 8 或 Oracle JDK 8)
- **Maven**: 3.6+ (用于后端项目构建)
- **MySQL**: 8.0+ (数据库)
- **Redis**: 5.0+ (缓存服务)
- **Node.js**: 16+ (前端开发和构建)

### 生产环境
- **服务器**: Linux服务器 (推荐 Ubuntu 20.04 或 CentOS 7+)
- **硬件配置**: 2核4G内存 (最低配置)，推荐4核8G
- **存储空间**: 20GB磁盘空间
- **网络**: 公网IP地址，开放80、443端口

## 🐳 部署方式

### 方式一：Docker Compose 部署 (强烈推荐)

这是最简单、最可靠的部署方式，适合生产环境。

#### 1. 准备 docker-compose.yml

```yaml
version: '3.8'

services:
  # MySQL 数据库
  mysql:
    image: mysql:8.0
    container_name: blog-mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: your_root_password
      MYSQL_DATABASE: blog
      MYSQL_USER: blog_user
      MYSQL_PASSWORD: your_blog_password
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
      - ./docs/database.sql:/docker-entrypoint-initdb.d/init.sql
    command: --default-authentication-plugin=mysql_native_password
    networks:
      - blog-network

  # Redis 缓存
  redis:
    image: redis:6.2-alpine
    container_name: blog-redis
    restart: always
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    networks:
      - blog-network
    command: redis-server --appendonly yes

  backend:
    build: ./backend
    container_name: blog-backend
    restart: always
    ports:
      - "8080:8080"
    environment:
      SPRING_PROFILES_ACTIVE: prod
      MYSQL_HOST: mysql
      MYSQL_PORT: 3306
      MYSQL_DATABASE: blog_db
      MYSQL_USERNAME: blog_user
      MYSQL_PASSWORD: blog123456
      REDIS_HOST: redis
      REDIS_PORT: 6379
    depends_on:
      - mysql
      - redis
    volumes:
      - ./upload:/app/upload

  frontend:
    build: ./frontend
    container_name: blog-frontend
    restart: always
    ports:
      - "80:80"
    depends_on:
      - backend

volumes:
  mysql_data:
  redis_data:
```

#### 2. 创建后端 Dockerfile

在 `backend/` 目录下创建 `Dockerfile`:

```dockerfile
FROM openjdk:8-jre-slim

WORKDIR /app

COPY target/blog-backend-1.0.0.jar app.jar
COPY src/main/resources/application-prod.yml application-prod.yml

EXPOSE 8080

CMD ["java", "-jar", "app.jar", "--spring.profiles.active=prod"]
```

#### 3. 创建前端 Dockerfile

在 `frontend/` 目录下创建 `Dockerfile`:

```dockerfile
# 构建阶段
FROM node:16-alpine as builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# 运行阶段
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

#### 4. 创建 Nginx 配置

在 `frontend/` 目录下创建 `nginx.conf`:

```nginx
events {
    worker_connections 1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    server {
        listen 80;
        server_name localhost;
        root /usr/share/nginx/html;
        index index.html;

        # 前端路由支持
        location / {
            try_files $uri $uri/ /index.html;
        }

        # API代理
        location /api/ {
            proxy_pass http://backend:8080/api/;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        # 静态资源缓存
        location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
            expires 1y;
            add_header Cache-Control "public, immutable";
        }
    }
}
```

#### 5. 部署命令

```bash
# 构建并启动所有服务
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f backend
docker-compose logs -f frontend

# 停止服务
docker-compose down
```

### 方式二：传统部署

#### 1. 服务器环境准备

```bash
# 安装 JDK 8
sudo apt update
sudo apt install openjdk-8-jdk

# 安装 MySQL
sudo apt install mysql-server
sudo mysql_secure_installation

# 安装 Redis
sudo apt install redis-server

# 安装 Nginx
sudo apt install nginx

# 安装 Node.js
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install nodejs
```

#### 2. 数据库初始化

```bash
# 登录 MySQL
sudo mysql -u root -p

# 创建数据库和用户
CREATE DATABASE blog_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'blog_user'@'localhost' IDENTIFIED BY 'blog123456';
GRANT ALL PRIVILEGES ON blog_db.* TO 'blog_user'@'localhost';
FLUSH PRIVILEGES;

# 导入数据
mysql -u blog_user -p blog_db < docs/database.sql
```

#### 3. 后端部署

```bash
# 打包后端项目
cd backend
mvn clean package -Dmaven.test.skip=true

# 创建应用目录
sudo mkdir -p /opt/blog/backend
sudo mkdir -p /opt/blog/logs
sudo mkdir -p /opt/blog/upload

# 复制jar包
sudo cp target/blog-backend-1.0.0.jar /opt/blog/backend/
sudo cp src/main/resources/application-prod.yml /opt/blog/backend/

# 创建启动脚本
sudo tee /opt/blog/backend/start.sh > /dev/null <<EOF
#!/bin/bash
cd /opt/blog/backend
java -jar blog-backend-1.0.0.jar --spring.profiles.active=prod > /opt/blog/logs/backend.log 2>&1 &
echo \$! > /opt/blog/backend/pid
EOF

sudo chmod +x /opt/blog/backend/start.sh

# 创建系统服务
sudo tee /etc/systemd/system/blog-backend.service > /dev/null <<EOF
[Unit]
Description=Blog Backend Service
After=network.target

[Service]
Type=forking
User=root
ExecStart=/opt/blog/backend/start.sh
ExecStop=/bin/kill \$(cat /opt/blog/backend/pid)
PIDFile=/opt/blog/backend/pid
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 启动服务
sudo systemctl daemon-reload
sudo systemctl enable blog-backend
sudo systemctl start blog-backend
```

#### 4. 前端部署

```bash
# 构建前端项目
cd frontend
npm install
npm run build

# 复制到Nginx目录
sudo cp -r dist/* /var/www/html/

# 配置Nginx
sudo tee /etc/nginx/sites-available/blog > /dev/null <<EOF
server {
    listen 80;
    server_name your-domain.com;
    root /var/www/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ /index.html;
    }

    location /api/ {
        proxy_pass http://localhost:8080/api/;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# 启用站点
sudo ln -s /etc/nginx/sites-available/blog /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## 生产环境配置

### 1. 数据库优化

```sql
-- 调整MySQL配置 /etc/mysql/mysql.conf.d/mysqld.cnf
[mysqld]
max_connections = 200
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2
```

### 2. Redis 配置

```bash
# 编辑 /etc/redis/redis.conf
maxmemory 512mb
maxmemory-policy allkeys-lru
save 900 1
save 300 10
save 60 10000
```

### 3. 应用配置

`backend/src/main/resources/application-prod.yml`:

```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/blog_db?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai
    username: blog_user
    password: blog123456
    driver-class-name: com.mysql.cj.jdbc.Driver
    hikari:
      minimum-idle: 5
      maximum-pool-size: 20

  redis:
    host: localhost
    port: 6379
    timeout: 3000ms
    lettuce:
      pool:
        max-active: 20
        max-idle: 10
        min-idle: 0

  servlet:
    multipart:
      max-file-size: 5MB
      max-request-size: 10MB

mybatis-plus:
  configuration:
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
  global-config:
    db-config:
      logic-delete-field: deleted
      logic-delete-value: 1
      logic-not-delete-value: 0

logging:
  level:
    com.blog: INFO
  file:
    name: /opt/blog/logs/backend.log
  pattern:
    file: "%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n"

# JWT配置
jwt:
  secret: your-secret-key-here
  expiration: 86400000

# 文件上传路径
file:
  upload-path: /opt/blog/upload/
  access-url: http://your-domain.com/upload/
```

## 域名和SSL配置

### 1. 域名解析

将域名 A 记录指向服务器IP地址

### 2. SSL证书配置 (Let's Encrypt)

```bash
# 安装 Certbot
sudo apt install certbot python3-certbot-nginx

# 获取SSL证书
sudo certbot --nginx -d your-domain.com

# 自动续期
sudo crontab -e
# 添加: 0 12 * * * /usr/bin/certbot renew --quiet
```

### 3. Nginx HTTPS 配置

```nginx
server {
    listen 80;
    server_name your-domain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name your-domain.com;
    
    ssl_certificate /etc/letsencrypt/live/your-domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/your-domain.com/privkey.pem;
    
    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api/ {
        proxy_pass http://localhost:8080/api/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 监控和维护

### 1. 日志监控

```bash
# 查看后端日志
tail -f /opt/blog/logs/backend.log

# 查看Nginx访问日志
tail -f /var/log/nginx/access.log

# 查看MySQL慢查询日志
tail -f /var/log/mysql/slow.log
```

### 2. 性能监控

```bash
# 安装 htop
sudo apt install htop

# 查看系统资源
htop

# 查看磁盘使用
df -h

# 查看内存使用
free -h
```

### 3. 数据备份

```bash
# MySQL 备份脚本
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
mysqldump -u blog_user -p blog_db > /opt/blog/backup/blog_db_$DATE.sql
find /opt/blog/backup -name "*.sql" -mtime +7 -delete

# 添加到 crontab
0 2 * * * /opt/blog/backup.sh
```

### 4. 更新部署

```bash
# 后端更新
sudo systemctl stop blog-backend
sudo cp target/blog-backend-1.0.0.jar /opt/blog/backend/
sudo systemctl start blog-backend

# 前端更新
npm run build
sudo cp -r dist/* /var/www/html/
sudo systemctl reload nginx
```
