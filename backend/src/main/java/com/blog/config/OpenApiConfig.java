package com.blog.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * SpringDoc OpenAPI 3 配置
 * 
 * @author blog
 * @date 2024-01-01
 */
@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(apiInfo())
                .servers(java.util.Arrays.asList(
                        new Server().url("http://localhost:8080").description("开发环境"),
                        new Server().url("https://api.yourdomain.com").description("生产环境")
                ))
                .components(new Components()
                        .addSecuritySchemes("Bearer Token", 
                                new SecurityScheme()
                                        .type(SecurityScheme.Type.HTTP)
                                        .scheme("bearer")
                                        .bearerFormat("JWT")
                                        .description("请输入 JWT Token，格式：Bearer {token}")
                        )
                )
                .addSecurityItem(new SecurityRequirement().addList("Bearer Token"));
    }

    /**
     * API 信息
     */
    private Info apiInfo() {
        return new Info()
                .title("个人博客系统 API")
                .description("基于 Spring Boot + Vue3 的前后端分离个人博客系统 RESTful API 文档")
                .version("1.0.0")
                .contact(new Contact()
                        .name("博客系统开发者")
                        .email("sunhao@stu.cqie.edu.cn")
                        .url("https://github.com/kangkangqing/blog")
                )
                .license(new License()
                        .name("MIT License")
                        .url("https://opensource.org/licenses/MIT")
                );
    }

}
