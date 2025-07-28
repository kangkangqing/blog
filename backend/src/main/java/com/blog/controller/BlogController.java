package com.blog.controller;
import com.blog.common.result.Result;
import com.blog.entity.BlogArticle;
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
 * 博客控制器
 * 
 * @author blog
 * @date 2024-01-01
 */
@Tag(name = "博客管理", description = "博客文章的增删改查操作")
@RestController
@RequestMapping("/blog")
public class BlogController {

    @Operation(summary = "获取博客列表", description = "分页获取博客文章列表，支持按分类、标签筛选")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "获取成功"),
            @ApiResponse(responseCode = "400", description = "参数错误")
    })
    @GetMapping("/list")
    public Result<List<BlogArticle>> getBlogList(
            @Parameter(description = "页码", example = "1") @RequestParam(defaultValue = "1") Integer page,
            @Parameter(description = "每页大小", example = "10") @RequestParam(defaultValue = "10") Integer size,
            @Parameter(description = "分类ID", example = "1") @RequestParam(required = false) Long categoryId,
            @Parameter(description = "标签ID", example = "1") @RequestParam(required = false) Long tagId,
            @Parameter(description = "搜索关键词") @RequestParam(required = false) String keyword) {
        // TODO: 实现获取博客列表逻辑
        return Result.success("博客列表获取成功");
    }

    @Operation(summary = "获取博客详情", description = "根据博客ID获取文章详细内容")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "获取成功"),
            @ApiResponse(responseCode = "404", description = "博客不存在")
    })
    @GetMapping("/{id}")
    public Result<BlogArticle> getBlogById(
            @Parameter(description = "博客ID", required = true, example = "1") @PathVariable Long id) {
        // TODO: 实现获取博客详情逻辑
        return Result.success("博客详情获取成功");
    }

    @Operation(summary = "创建博客", description = "发布新的博客文章")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "创建成功"),
            @ApiResponse(responseCode = "400", description = "参数错误"),
            @ApiResponse(responseCode = "401", description = "未授权访问")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PostMapping
    public Result<BlogArticle> createBlog(@Parameter(description = "博客信息") @Valid @RequestBody BlogArticle blog) {
        // TODO: 实现创建博客逻辑
        return Result.success("博客创建成功");
    }

    @Operation(summary = "更新博客", description = "更新指定ID的博客文章")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "更新成功"),
            @ApiResponse(responseCode = "400", description = "参数错误"),
            @ApiResponse(responseCode = "404", description = "博客不存在"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @PutMapping("/{id}")
    public Result<BlogArticle> updateBlog(
            @Parameter(description = "博客ID", required = true) @PathVariable Long id,
            @Parameter(description = "博客信息") @Valid @RequestBody BlogArticle article) {
        // TODO: 实现更新博客逻辑
        return Result.success("博客更新成功");
    }

    @Operation(summary = "删除博客", description = "根据ID删除博客文章（软删除）")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "删除成功"),
            @ApiResponse(responseCode = "404", description = "博客不存在"),
            @ApiResponse(responseCode = "403", description = "权限不足")
    })
    @SecurityRequirement(name = "Bearer Token")
    @DeleteMapping("/{id}")
    public Result<Void> deleteBlog(
            @Parameter(description = "博客ID", required = true) @PathVariable Long id) {
        // TODO: 实现删除博客逻辑
        return Result.success("博客删除成功");
    }

    @Operation(summary = "获取热门博客", description = "获取浏览量最高的博客文章")
    @GetMapping("/hot")
    public Result<List<BlogArticle>> getHotBlogs(
            @Parameter(description = "数量限制", example = "10") @RequestParam(defaultValue = "10") Integer limit) {
        // TODO: 实现获取热门博客逻辑
        return Result.success("热门博客获取成功");
    }

    @Operation(summary = "获取推荐博客", description = "获取系统推荐的博客文章")
    @GetMapping("/recommend")
    public Result<List<BlogArticle>> getRecommendBlogs(
            @Parameter(description = "数量限制", example = "5") @RequestParam(defaultValue = "5") Integer limit) {
        // TODO: 实现获取推荐博客逻辑
        return Result.success("推荐博客获取成功");
    }

}
