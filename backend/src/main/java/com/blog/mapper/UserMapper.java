package com.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.blog.entity.User;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户Mapper接口
 * 
 * @author blog
 * @date 2024-01-01
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {
    
}
