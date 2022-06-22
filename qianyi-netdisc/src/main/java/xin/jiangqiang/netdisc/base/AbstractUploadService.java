package xin.jiangqiang.netdisc.base;

import com.ruoyi.common.config.QianYiConfig;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
public abstract class AbstractUploadService implements BaseUploadService {
    @Autowired
    protected QianYiConfig qianYiConfig;
}
