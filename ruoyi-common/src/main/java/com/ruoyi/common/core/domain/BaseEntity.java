package com.ruoyi.common.core.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;

/**
 * Entity基类
 *
 * @author ruoyi
 */
@Getter
@Setter
public class BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 搜索值
     */
    @TableField(exist = false)
    private String searchValue;

    /**
     * 创建者
     */
    @TableField(
            fill = FieldFill.INSERT
    )
    private String createBy;

    /**
     * 创建时间
     */
    @TableField(
            fill = FieldFill.INSERT
    )
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /**
     * 更新者
     */
    @TableField(
            fill = FieldFill.UPDATE
    )
    private String updateBy;

    /**
     * 更新时间
     */
    @TableField(
            fill = FieldFill.UPDATE
    )
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    /**
     * 备注
     */
    @TableField(exist = false)
    private String remark;

    /**
     * 请求参数
     */
    @Getter(AccessLevel.NONE)
    @TableField(exist = false)
    private Map<String, Object> params;


    public Map<String, Object> getParams() {
        return params == null ? new HashMap<>() : params;
    }

}
