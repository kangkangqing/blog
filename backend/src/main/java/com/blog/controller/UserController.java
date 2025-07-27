package com.blog.controller;

import com.blog.common.Result;
import com.blog.entity.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * 用户控制器
 * 
 * @author blog
 * @date 2024-01-01
 */
@Tag(name = "用户管理", description = "用户相关的增删改查操作")
@RestController
@RequestMapping("/user")
public class UserController {

    @Operation(summary = "获取用户列表", description = "分页获取所有用户信息")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "获取成功"),
            @ApiResponse(responseCode = "401", description = "未授权访问"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @GetMapping("/list")
    public Result<List<User>> getUserList(
            @Parameter(description = "页码", example = "1") @RequestParam(defaultValue = "1") Integer page,
            @Parameter(description = "每页大小", example = "10") @RequestParam(defaultValue = "10") Integer size) {
        // TODO: 实现获取用户列表逻辑
        return Result.success("用户列表获取成功");
    }

    @Operation(summary = "根据ID获取用户", description = "通过用户ID获取单个用户详细信息")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "获取成功"),
            @ApiResponse(responseCode = "404", description = "用户不存在"),
            @ApiResponse(responseCode = "401", description = "未授权访问")
    })
    @SecurityRequirement(name = "Bearer Token")
    @GetMapping("/{id}")
    public Result<User> getUserById(
            @Parameter(description = "用户ID", required = true, example = "1") @PathVariable Long id) {
        // TODO: 实现根据ID获取用户逻辑
        return Result.success("用户信息获取成功");
    }

    @Operation(summary = "创建用户", description = "创建新的用户账户")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "创建成功"),
            @ApiResponse(responseCode = "400", description = "参数错误"),
            @ApiResponse(responseCode = "409", description = "用户已存在")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PostMapping
    public Result<User> createUser(@Parameter(description = "用户信息") @Valid @RequestBody User user) {
        // TODO: 实现创建用户逻辑
        return Result.success("用户创建成功");
    }

    @Operation(summary = "更新用户", description = "更新指定ID的用户信息")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "更新成功"),
            @ApiResponse(responseCode = "400", description = "参数错误"),
            @ApiResponse(responseCode = "404", description = "用户不存在")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PutMapping("/{id}")
    public Result<User> updateUser(
            @Parameter(description = "用户ID", required = true) @PathVariable Long id,
            @Parameter(description = "用户信息") @Valid @RequestBody User user) {
        // TODO: 实现更新用户逻辑
        return Result.success("用户更新成功");
    }

    @Operation(summary = "删除用户", description = "根据ID删除用户（软删除）")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "删除成功"),
            @ApiResponse(responseCode = "404", description = "用户不存在"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @DeleteMapping("/{id}")
    public Result<Void> deleteUser(
            @Parameter(description = "用户ID", required = true) @PathVariable Long id) {
        // TODO: 实现删除用户逻辑
        return Result.success("用户删除成功");
    }

}
