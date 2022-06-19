package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import lombok.*;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 文章新增对象 qy_articles
 *
 * @author JiangQiang
 * @date 2022-06-17
 */
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class Articles extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 文章id
     */
    private Long articleId;

    /**
     * 文章标题
     */
    @Excel(name = "文章标题")
    private String storageTitle;

    /**
     * 文章原始内容
     */
    @Excel(name = "文章原始内容")
    private String originalContent;

    /**
     * 文章html内容
     */
    @Excel(name = "文章html内容")
    private String htmlContent;

    /**
     * 文章固定链接
     */
    @Excel(name = "文章固定链接")
    private String articleUrl;

    /**
     * 文章分类
     */
    @Excel(name = "文章分类")
    private Long categoryId;

    /**
     * 文章标签id组成的字符串
     */
    @Excel(name = "文章标签id组成的字符串")
    private String tagIds;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    private String delFlag;


    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("articleId", getArticleId())
                .append("storageTitle", getStorageTitle())
                .append("originalContent", getOriginalContent())
                .append("htmlContent", getHtmlContent())
                .append("articleUrl", getArticleUrl())
                .append("categoryId", getCategoryId())
                .append("tagIds", getTagIds())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
