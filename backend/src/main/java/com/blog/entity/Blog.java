package com.blog.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * 博客实体类
 * 
 * @author blog
 * @date 2024-01-01
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("t_blog")
public class Blog {

    /**
     * 博客ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 标题
     */
    @TableField("title")
    private String title;

    /**
     * 内容
     */
    @TableField("content")
    private String content;

    /**
     * 摘要
     */
    @TableField("summary")
    private String summary;

    /**
     * 封面图片
     */
    @TableField("cover_image")
    private String coverImage;

    /**
     * 分类ID
     */
    @TableField("category_id")
    private Long categoryId;

    /**
     * 作者ID
     */
    @TableField("user_id")
    private Long userId;

    /**
     * 是否置顶：0-否，1-是
     */
    @TableField("is_top")
    private Integer isTop;

    /**
     * 是否推荐：0-否，1-是
     */
    @TableField("is_recommend")
    private Integer isRecommend;

    /**
     * 是否原创：0-否，1-是
     */
    @TableField("is_original")
    private Integer isOriginal;

    /**
     * 状态：0-草稿，1-发布，2-私密
     */
    @TableField("status")
    private Integer status;

    /**
     * 浏览量
     */
    @TableField("view_count")
    private Integer viewCount;

    /**
     * 评论数量
     */
    @TableField("comment_count")
    private Integer commentCount;

    /**
     * 发布时间
     */
    @TableField("publish_time")
    private LocalDateTime publishTime;

    /**
     * 创建时间
     */
    @TableField(value = "create_time", fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    @TableField(value = "update_time", fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    /**
     * 是否删除：0-未删除，1-已删除
     */
    @TableLogic
    @TableField("deleted")
    private Integer deleted;

}
