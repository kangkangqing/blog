package com.blog.common;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

/**
 * MyBatis Plus 元数据处理器
 * 用于自动填充创建时间和更新时间
 *
 * @author blog
 * @date 2024-01-01
 */
@Slf4j
@Component
public class MetaObjectHandlerConfig implements MetaObjectHandler {

    /**
     * 插入时自动填充
     */
    @Override
    public void insertFill(MetaObject metaObject) {
        log.info("开始插入填充...");
        
        // 设置创建时间
        this.strictInsertFill(metaObject, "createTime", LocalDateTime.class, LocalDateTime.now());
        
        // 设置更新时间
        this.strictInsertFill(metaObject, "updateTime", LocalDateTime.class, LocalDateTime.now());
        
        // 设置默认值
        this.setDefaultValue(metaObject, "deleted", 0);
        this.setDefaultValue(metaObject, "status", 1);
        this.setDefaultValue(metaObject, "viewCount", 0);
        this.setDefaultValue(metaObject, "commentCount", 0);
        this.setDefaultValue(metaObject, "sort", 0);
        this.setDefaultValue(metaObject, "isTop", 0);
        this.setDefaultValue(metaObject, "isRecommend", 0);
        this.setDefaultValue(metaObject, "isOriginal", 1);
    }

    /**
     * 更新时自动填充
     */
    @Override
    public void updateFill(MetaObject metaObject) {
        log.info("开始更新填充...");
        
        // 设置更新时间
        this.strictUpdateFill(metaObject, "updateTime", LocalDateTime.class, LocalDateTime.now());
    }

    /**
     * 填充策略 - 设置默认值
     */
    private void setDefaultValue(MetaObject metaObject, String fieldName, Object fieldVal) {
        if (getFieldValByName(fieldName, metaObject) == null) {
            this.setFieldValByName(fieldName, fieldVal, metaObject);
        }
    }

}
