package xin.jiangqiang.netdisc.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import xin.jiangqiang.netdisc.service.IStoragesService;

/**
 * 从数据库中读取配置
 *
 * @author jiangqiang
 * @date 2022-06-23
 */
@Configuration
public class StorageConfig {
    @Autowired
    IStoragesService storagesService;


}
