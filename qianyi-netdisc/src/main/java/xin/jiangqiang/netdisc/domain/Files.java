package xin.jiangqiang.netdisc.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseDomain;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import lombok.experimental.Accessors;

/**
 * 文件对象 qy_files
 *
 * @author JiangQiang
 * @date 2022-06-22
 */
@Builder
@ApiModel
@Data
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@TableName("qy_files")
public class Files extends BaseDomain {
    private static final long serialVersionUID = 1L;

    /**
     * 文件或目录id
     */
    @Excel(name = "文件或目录id")
    @TableId(value = "file_id", type = IdType.AUTO)
    @ApiModelProperty("文件或目录id")
    private Long fileId;

    /**
     * 文件或目录原始名称，不包含后缀
     */
    @Excel(name = "文件或目录原始名称，不包含后缀")
    @TableField("file_name")
    @ApiModelProperty("文件或目录原始名称，不包含后缀")
    private String fileName;

    /**
     * 文件或目录原始名称，不包含后缀
     */
    @Excel(name = "完整文件或目录名")
    @TableField(exist = false)
    @ApiModelProperty("完整文件或目录名")
    private String fullFileName;

    /**
     * 文件名后缀，不包含小数点
     */
    @Excel(name = "文件名后缀，不包含小数点")
    @TableField(value = "suffix", fill = FieldFill.INSERT)
    @ApiModelProperty("文件名后缀，不包含小数点")
    private String suffix;

    /**
     * 文件大小
     */
    @Excel(name = "文件大小")
    @TableField("size")
    @ApiModelProperty("文件大小")
    private Long size;

    /**
     * 文件传输类型
     */
    @Excel(name = "文件传输类型")
    @TableField("mime_type")
    @ApiModelProperty("文件传输类型")
    private String mimeType;

    /**
     * 存储类型id，OSS/本地
     */
    @Excel(name = "存储类型id，OSS/本地")
    @TableField(value = "storage_id", fill = FieldFill.INSERT)
    @ApiModelProperty("存储类型id，OSS/本地")
    private Long storageId;

    /**
     * 服务端存储路径
     */
    @Excel(name = "服务端存储路径")
    @TableField("upload_path")
    @ApiModelProperty("服务端存储路径")
    private String uploadPath;

    /**
     * 文件的唯一key
     */
    @Excel(name = "文件的唯一key")
    @TableField("file_key")
    @ApiModelProperty("文件的唯一key")
    private String fileKey;

    /**
     * 是否为目录，0表示文件，1表示目录
     */
    @Excel(name = "是否为目录，0表示文件，1表示目录")
    @TableField("is_dir")
    @ApiModelProperty("是否为目录，0表示文件，1表示目录")
    private Boolean isDir;

    /**
     * 父级目录id，如果为0则为根目录
     */
    @Excel(name = "父级目录id，如果为0则为根目录，-1为博客系统默认上传目录")
    @TableField(value = "parent_id", fill = FieldFill.INSERT)
    @ApiModelProperty("父级目录id，如果为0则为根目录，-1为博客系统默认上传目录")
    private Long parentId;

    /**
     * 父级目录id，如果为0则为根目录
     */
    @Excel(name = "同一个目录下，不可重复")
    @TableField(value = "random_key")
    @ApiModelProperty("同一个目录下，不可重复")
    private String randomKey;

    /**
     * 是否公开，1表示所有人可以访问，0表示需要访问权限
     */
    @Excel(name = "是否公开，1表示所有人可以访问，0表示需要访问权限")
    @TableField(value = "is_public", fill = FieldFill.INSERT)
    @ApiModelProperty("是否公开，1表示所有人可以访问，0表示需要访问权限")
    private Boolean isPublic;

    @Excel(name = "文件摘要算法计算得出的唯一值")
    @TableField(value = "identifier")
    @ApiModelProperty("文件摘要算法计算得出的唯一值")
    private String identifier;

}
