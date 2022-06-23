package xin.jiangqiang.netdisc.base;

import com.ruoyi.common.config.QianYiConfig;
import lombok.Getter;
import lombok.Setter;
import xin.jiangqiang.netdisc.service.IFilesService;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
@Getter
@Setter
public abstract class AbstractUploadService<T> implements BaseUploadService {
    protected QianYiConfig qianYiConfig;
    protected IFilesService fileService;
    protected T client;
}
