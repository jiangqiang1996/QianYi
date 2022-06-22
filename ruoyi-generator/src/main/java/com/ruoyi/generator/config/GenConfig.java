package com.ruoyi.generator.config;

import lombok.Getter;
import lombok.Setter;
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
@Getter
@Setter
public class GenConfig {
    /**
     * 作者
     */
    @Value("${author}")
    public String author;

    /**
     * 生成包路径
     */
    @Value("${packageName}")
    public String packageName;

    /**
     * 自动去除表前缀，默认是false
     */
    @Value("${autoRemovePre}")
    public boolean autoRemovePre;

    /**
     * 表前缀(类名不会包含表前缀)
     */
    @Value("${tablePrefix}")
    public String tablePrefix;

}
