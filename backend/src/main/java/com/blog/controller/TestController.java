package com.blog.controller;

import com.blog.common.Result;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 测试控制器
 * 
 * @author blog
 * @date 2024-01-01
 */
@Tag(name = "测试接口", description = "系统测试相关接口")
@RestController
@RequestMapping("/test")
public class TestController {

    @Operation(summary = "系统健康检查", description = "测试系统是否正常运行")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "系统运行正常"),
            @ApiResponse(responseCode = "500", description = "系统内部错误")
    })
    @GetMapping("/hello")
    public Result<String> hello() {
        return Result.success("Hello, Blog System!");
    }
    
    @Operation(summary = "获取系统信息", description = "获取当前系统的基本信息")
    @GetMapping("/info")
    public Result<Object> getSystemInfo() {
        return Result.success("系统版本: 1.0.0");
    }

}
