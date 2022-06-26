package xin.jiangqiang.netdisc.base;

import com.ruoyi.common.config.QianYiConfig;
import com.ruoyi.common.core.domain.AjaxResult;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;
import xin.jiangqiang.netdisc.domain.dto.FileDto;
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
