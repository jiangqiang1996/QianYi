package xin.jiangqiang.netdisc.base;

import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.web.multipart.MultipartFile;
import xin.jiangqiang.netdisc.domain.Files;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
public interface BaseUploadService {
    AjaxResult singleUpload(MultipartFile file, Files fileObj);

    AjaxResult batchUpload(MultipartFile[] files, Files fileObj);

    AjaxResult patchSingleUpload(MultipartFile file, Files fileObj);

    AjaxResult patchBatchUpload(MultipartFile[] files, Files fileObj);

    AjaxResult getProcess(Long fileId);
}
