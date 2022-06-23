package xin.jiangqiang.netdisc.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseDomain;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import lombok.experimental.Accessors;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import xin.jiangqiang.netdisc.config.Config;

/**
 * 存储类型对象 qy_storages
 *
 * @author JiangQiang
 * @date 2022-06-23
 */
@Builder
@ApiModel
@Data
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@TableName(value = "qy_storages", autoResultMap = true)
public class Storages extends BaseDomain {
    private static final long serialVersionUID = 1L;

    /**
     * 存储类型id
     */
    @Excel(name = "存储类型id")
    @TableId(value = "storage_id", type = IdType.AUTO)
    @ApiModelProperty("存储类型id")
    private Long storageId;
    /**
     * 类型名称
     */
    @Excel(name = "类型名称")
    @TableField("storage_name")
    @ApiModelProperty("类型名称")
    private String storageName;
    /**
     * 存储类型相关配置
     */
    @Excel(name = "存储类型相关配置")
    @TableField(value = "storage_config", typeHandler = JacksonTypeHandler.class)
    @ApiModelProperty("存储类型相关配置")
    private Config storageConfig;

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("storageId", getStorageId())
                .append("storageName", getStorageName())
                .append("storageConfig", getStorageConfig())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
