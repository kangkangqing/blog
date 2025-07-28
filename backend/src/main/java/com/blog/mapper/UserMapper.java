package com.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.blog.entity.Role;
import com.blog.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 用户Mapper接口
 * 
 * @author blog
 * @date 2024-01-01
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {

    /**
     * 根据用户ID查询用户角色
     */
    @Select("SELECT r.* FROM t_role r " +
            "LEFT JOIN t_user_role ur ON r.id = ur.role_id " +
            "WHERE ur.user_id = #{userId} AND r.status = 1")
    List<Role> selectRolesByUserId(@Param("userId") Long userId);

    /**
     * 根据用户名或邮箱查询用户
     */
    @Select("SELECT * FROM t_user WHERE (username = #{usernameOrEmail} OR email = #{usernameOrEmail})")
    User selectByUsernameOrEmail(@Param("usernameOrEmail") String usernameOrEmail);
    
}
