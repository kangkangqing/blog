package com.blog.common;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 响应状态码枚举
 *
 * @author blog
 * @date 2024-01-01
 */
@Getter
@AllArgsConstructor
public enum ResultCode {

    /**
     * 成功
     */
    SUCCESS(200, "操作成功"),

    /**
     * 失败
     */
    ERROR(500, "操作失败"),

    /**
     * 参数错误
     */
    PARAM_ERROR(400, "参数错误"),

    /**
     * 未授权
     */
    UNAUTHORIZED(401, "未授权"),

    /**
     * 禁止访问
     */
    FORBIDDEN(403, "禁止访问"),

    /**
     * 资源不存在
     */
    NOT_FOUND(404, "资源不存在"),

    /**
     * 请求方法不允许
     */
    METHOD_NOT_ALLOWED(405, "请求方法不允许"),

    /**
     * 用户名或密码错误
     */
    LOGIN_ERROR(1001, "用户名或密码错误"),

    /**
     * 用户不存在
     */
    USER_NOT_EXIST(1002, "用户不存在"),

    /**
     * 用户已被禁用
     */
    USER_DISABLED(1003, "用户已被禁用"),

    /**
     * 用户名已存在
     */
    USERNAME_EXIST(1004, "用户名已存在"),

    /**
     * 邮箱已存在
     */
    EMAIL_EXIST(1005, "邮箱已存在"),

    /**
     * 验证码错误
     */
    CAPTCHA_ERROR(1006, "验证码错误"),

    /**
     * 操作频繁
     */
    OPERATION_FREQUENT(1007, "操作过于频繁"),

    /**
     * 文件上传失败
     */
    FILE_UPLOAD_ERROR(2001, "文件上传失败"),

    /**
     * 文件类型不支持
     */
    FILE_TYPE_ERROR(2002, "文件类型不支持"),

    /**
     * 文件大小超出限制
     */
    FILE_SIZE_ERROR(2003, "文件大小超出限制"),

    /**
     * 数据不存在
     */
    DATA_NOT_EXIST(3001, "数据不存在"),

    /**
     * 数据已存在
     */
    DATA_EXIST(3002, "数据已存在"),

    /**
     * 数据状态异常
     */
    DATA_STATUS_ERROR(3003, "数据状态异常");

    private final Integer code;
    private final String message;

}
