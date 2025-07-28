package com.blog.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.blog.common.result.Result;
import com.blog.dto.ChangePasswordDto;
import com.blog.dto.UserUpdateDto;
import com.blog.service.UserService;
import com.blog.vo.UserVo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * 用户控制器
 * 
 * @author blog
 * @date 2024-01-01
 */
@Tag(name = "用户管理", description = "用户相关的增删改查操作")
@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @Operation(summary = "获取当前用户信息", description = "获取当前登录用户的详细信息")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "获取成功"),
            @ApiResponse(responseCode = "401", description = "未授权访问")
    })
    @SecurityRequirement(name = "Bearer Token")
    @GetMapping("/current")
    public Result<UserVo> getCurrentUser() {
        UserVo userVo = userService.getCurrentUser();
        return Result.success(userVo);
    }

    @Operation(summary = "修改密码", description = "修改当前用户的登录密码")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "修改成功"),
            @ApiResponse(responseCode = "400", description = "参数错误"),
            @ApiResponse(responseCode = "401", description = "未授权访问")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PutMapping("/password")
    public Result<Void> changePassword(@Valid @RequestBody ChangePasswordDto changePasswordDto) {
        userService.changePassword(changePasswordDto);
        return Result.success("密码修改成功");
    }

    @Operation(summary = "更新用户信息", description = "更新当前用户的基本信息")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "更新成功"),
            @ApiResponse(responseCode = "400", description = "参数错误"),
            @ApiResponse(responseCode = "401", description = "未授权访问")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PutMapping("/profile")
    public Result<Void> updateProfile(@Valid @RequestBody UserUpdateDto userUpdateDto) {
        userService.updateUser(userUpdateDto);
        return Result.success("用户信息更新成功");
    }

    @Operation(summary = "获取用户列表", description = "分页获取所有用户信息（管理员权限）")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "获取成功"),
            @ApiResponse(responseCode = "401", description = "未授权访问"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @GetMapping("/list")
    public Result<Page<UserVo>> getUserList(
            @Parameter(description = "页码", example = "1") @RequestParam(defaultValue = "1") Integer pageNum,
            @Parameter(description = "每页大小", example = "10") @RequestParam(defaultValue = "10") Integer pageSize,
            @Parameter(description = "搜索关键词") @RequestParam(required = false) String keyword) {
        Page<UserVo> userList = userService.getUserList(pageNum, pageSize, keyword);
        return Result.success(userList);
    }

    @Operation(summary = "根据ID获取用户", description = "通过用户ID获取单个用户详细信息（管理员权限）")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "获取成功"),
            @ApiResponse(responseCode = "404", description = "用户不存在"),
            @ApiResponse(responseCode = "401", description = "未授权访问")
    })
    @SecurityRequirement(name = "Bearer Token")
    @GetMapping("/{id}")
    public Result<UserVo> getUserById(
            @Parameter(description = "用户ID", required = true, example = "1") @PathVariable Long id) {
        UserVo userVo = userService.getUserById(id);
        return Result.success(userVo);
    }

    @Operation(summary = "更新用户信息", description = "管理员更新指定用户信息")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "更新成功"),
            @ApiResponse(responseCode = "400", description = "参数错误"),
            @ApiResponse(responseCode = "404", description = "用户不存在"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PutMapping("/{id}/admin")
    public Result<Void> updateUserByAdmin(
            @Parameter(description = "用户ID", required = true) @PathVariable Long id,
            @Parameter(description = "用户信息") @Valid @RequestBody UserUpdateDto userUpdateDto) {
        userUpdateDto.setId(id);
        userService.updateUser(userUpdateDto);
        return Result.success("用户更新成功");
    }

    @Operation(summary = "删除用户", description = "根据ID删除用户（软删除，管理员权限）")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "删除成功"),
            @ApiResponse(responseCode = "404", description = "用户不存在"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @DeleteMapping("/{id}")
    public Result<Void> deleteUser(
            @Parameter(description = "用户ID", required = true) @PathVariable Long id) {
        userService.deleteUser(id);
        return Result.success("用户删除成功");
    }

    @Operation(summary = "批量删除用户", description = "批量删除多个用户（管理员权限）")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "删除成功"),
            @ApiResponse(responseCode = "400", description = "参数错误"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @DeleteMapping("/batch")
    public Result<Void> deleteUsers(
            @Parameter(description = "用户ID数组", required = true) @RequestBody Long[] ids) {
        userService.deleteUsers(ids);
        return Result.success("用户批量删除成功");
    }

    @Operation(summary = "更新用户状态", description = "启用/禁用用户（管理员权限）")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "更新成功"),
            @ApiResponse(responseCode = "404", description = "用户不存在"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PutMapping("/{id}/status")
    public Result<Void> updateUserStatus(
            @Parameter(description = "用户ID", required = true) @PathVariable Long id,
            @Parameter(description = "状态", required = true, example = "1") @RequestParam Integer status) {
        userService.updateUserStatus(id, status);
        return Result.success("用户状态更新成功");
    }

    @Operation(summary = "重置用户密码", description = "管理员重置用户密码")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "重置成功"),
            @ApiResponse(responseCode = "404", description = "用户不存在"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PutMapping("/{id}/reset-password")
    public Result<Void> resetPassword(
            @Parameter(description = "用户ID", required = true) @PathVariable Long id,
            @Parameter(description = "新密码", required = true) @RequestParam String newPassword) {
        userService.resetPassword(id, newPassword);
        return Result.success("密码重置成功");
    }

    @Operation(summary = "分配角色", description = "为用户分配角色（管理员权限）")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "分配成功"),
            @ApiResponse(responseCode = "404", description = "用户不存在"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PutMapping("/{id}/roles")
    public Result<Void> assignRoles(
            @Parameter(description = "用户ID", required = true) @PathVariable Long id,
            @Parameter(description = "角色ID数组", required = true) @RequestBody Long[] roleIds) {
        userService.assignRoles(id, roleIds);
        return Result.success("角色分配成功");
    }

}
