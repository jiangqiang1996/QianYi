package com.ruoyi.common.core.domain;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
@Getter
@Setter
public class BaseDomain extends BaseEntity {
    /**
     * 删除标志（0代表存在 2代表删除）
     */
    @TableLogic
    @JsonIgnore
    @TableField(value = "del_flag",
            fill = FieldFill.INSERT
    )
    private String delFlag;
}
