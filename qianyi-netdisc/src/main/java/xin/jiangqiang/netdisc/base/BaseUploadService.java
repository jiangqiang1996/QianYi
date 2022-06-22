package xin.jiangqiang.netdisc.base;

import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
public interface BaseUploadService {
    AjaxResult singleUpload(MultipartFile file);

    AjaxResult batchUpload(MultipartFile[] files);

    AjaxResult patchSingleUpload(MultipartFile file);

    AjaxResult patchBatchUpload(MultipartFile[] files);

    AjaxResult getProcess(Long fileId);
}
