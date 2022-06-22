package com.ruoyi.common.config;

import cn.hutool.core.io.FileUtil;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.io.File;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
@Component
@ConfigurationProperties(prefix = "qianyi")
@Setter
public class QianYiConfig {
    private NetDisc netdisc;

    @Setter
    private static class NetDisc {
        private String baseDir;
        private String cachePath;
        private String uploadPath;
    }

    public File getCacheDir() {
        return FileUtil.file(netdisc.baseDir, netdisc.cachePath);
    }

    public File getUploadDir() {
        return FileUtil.file(netdisc.baseDir, netdisc.uploadPath);
    }
}
