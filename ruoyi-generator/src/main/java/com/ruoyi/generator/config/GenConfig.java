package com.ruoyi.generator.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/**
 * 读取代码生成相关配置
 *
 * @author ruoyi
 */
@Component
@ConfigurationProperties(prefix = "gen")
@PropertySource(value = {"classpath:generator.yml"})
public class GenConfig {
    /**
     * 作者
     */
    @Value("${author}")
    public static String author;

    /**
     * 生成包路径
     */
    @Value("${packageName}")
    public static String packageName;

    /**
     * 自动去除表前缀，默认是false
     */
    @Value("${autoRemovePre}")
    public static boolean autoRemovePre;

    /**
     * 表前缀(类名不会包含表前缀)
     */
    @Value("${tablePrefix}")
    public static String tablePrefix;

    public static String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        GenConfig.author = author;
    }

    public static String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        GenConfig.packageName = packageName;
    }

    public static boolean getAutoRemovePre() {
        return autoRemovePre;
    }

    public void setAutoRemovePre(boolean autoRemovePre) {
        GenConfig.autoRemovePre = autoRemovePre;
    }

    public static String getTablePrefix() {
        return tablePrefix;
    }

    public void setTablePrefix(String tablePrefix) {
        GenConfig.tablePrefix = tablePrefix;
    }
}
