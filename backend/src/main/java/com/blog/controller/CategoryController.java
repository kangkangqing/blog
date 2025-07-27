package com.blog.controller;

import com.blog.common.Result;
import com.blog.entity.Category;
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
 * 分类控制器
 * 
 * @author blog
 * @date 2024-01-01
 */
@Tag(name = "分类管理", description = "博客分类的管理操作")
@RestController
@RequestMapping("/category")
public class CategoryController {

    @Operation(summary = "获取所有分类", description = "获取系统中所有的博客分类")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "获取成功")
    })
    @GetMapping("/list")
    public Result<List<Category>> getAllCategories() {
        // TODO: 实现获取所有分类逻辑
        return Result.success("分类列表获取成功");
    }

    @Operation(summary = "获取分类详情", description = "根据分类ID获取分类详细信息")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "获取成功"),
            @ApiResponse(responseCode = "404", description = "分类不存在")
    })
    @GetMapping("/{id}")
    public Result<Category> getCategoryById(
            @Parameter(description = "分类ID", required = true, example = "1") @PathVariable Long id) {
        // TODO: 实现获取分类详情逻辑
        return Result.success("分类详情获取成功");
    }

    @Operation(summary = "创建分类", description = "创建新的博客分类")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "创建成功"),
            @ApiResponse(responseCode = "400", description = "参数错误"),
            @ApiResponse(responseCode = "401", description = "未授权访问"),
            @ApiResponse(responseCode = "409", description = "分类名称已存在")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PostMapping
    public Result<Category> createCategory(
            @Parameter(description = "分类信息") @Valid @RequestBody Category category) {
        // TODO: 实现创建分类逻辑
        return Result.success("分类创建成功");
    }

    @Operation(summary = "更新分类", description = "更新指定ID的分类信息")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "更新成功"),
            @ApiResponse(responseCode = "400", description = "参数错误"),
            @ApiResponse(responseCode = "404", description = "分类不存在"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PutMapping("/{id}")
    public Result<Category> updateCategory(
            @Parameter(description = "分类ID", required = true) @PathVariable Long id,
            @Parameter(description = "分类信息") @Valid @RequestBody Category category) {
        // TODO: 实现更新分类逻辑
        return Result.success("分类更新成功");
    }

    @Operation(summary = "删除分类", description = "根据ID删除分类（需确保分类下无文章）")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "删除成功"),
            @ApiResponse(responseCode = "404", description = "分类不存在"),
            @ApiResponse(responseCode = "403", description = "权限不足"),
            @ApiResponse(responseCode = "409", description = "分类下存在文章，无法删除")
    })
    @SecurityRequirement(name = "Bearer Token")
    @DeleteMapping("/{id}")
    public Result<Void> deleteCategory(
            @Parameter(description = "分类ID", required = true) @PathVariable Long id) {
        // TODO: 实现删除分类逻辑
        return Result.success("分类删除成功");
    }

    @Operation(summary = "获取分类统计", description = "获取每个分类下的文章数量统计")
    @GetMapping("/stats")
    public Result<List<Object>> getCategoryStats() {
        // TODO: 实现获取分类统计逻辑
        return Result.success("分类统计获取成功");
    }

}
