package xin.jiangqiang.netdisc.service;

import cn.hutool.core.io.FileUtil;
import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import xin.jiangqiang.netdisc.base.AbstractUploadService;
import xin.jiangqiang.netdisc.base.UploadResult;
import xin.jiangqiang.netdisc.utils.UploadUtils;

import java.io.IOException;
import java.nio.file.Paths;

/**
 * 本地上传
 *
 * @author jiangqiang
 * @date 2022-06-22
 */
@Service
public class LocalUploadService extends AbstractUploadService {
    @Override
    public AjaxResult singleUpload(MultipartFile file) {
        UploadResult result = new UploadResult();
        // 原始文件名
        String originalFilename = file.getOriginalFilename();
        // 返回新文件名称，服务器上唯一
        String fileName = UploadUtils.genKey(originalFilename);
        try {
            file.transferTo(Paths.get(FileUtil.file(qianYiConfig.getUploadDir(), fileName).getAbsolutePath()));
            result.addSuccessFile(originalFilename, UploadUtils.getAccessUrl(fileName));
            return result.success();
        } catch (IOException e) {
            return result.error("文件[" + originalFilename + "]上传失败，错误原因：" + e.getMessage());
        }
    }

    @Override
    public AjaxResult batchUpload(MultipartFile[] files) {
        UploadResult result = new UploadResult();
        for (MultipartFile file : files) {
            // 原始文件名
            String originalFilename = file.getOriginalFilename();
            // 返回新文件名称，服务器上唯一
            String fileName = UploadUtils.genKey(originalFilename);
            try {
                file.transferTo(Paths.get(FileUtil.file(qianYiConfig.getUploadDir(), fileName).getAbsolutePath()));
                result.addSuccessFile(originalFilename, UploadUtils.getAccessUrl(fileName));
            } catch (IOException e) {
               result.addErrFile(originalFilename);
            }
        }
        return result.success();
    }

    @Override
    public AjaxResult patchSingleUpload(MultipartFile file) {
        return null;
    }

    @Override
    public AjaxResult patchBatchUpload(MultipartFile[] files) {
        return null;
    }

    @Override
    public AjaxResult getProcess(Long fileId) {
        return null;
    }
}
