package xin.jiangqiang.netdisc.service.other;

import cn.hutool.core.io.FileUtil;
import com.qcloud.cos.COSClient;
import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import xin.jiangqiang.netdisc.base.AbstractUploadService;
import xin.jiangqiang.netdisc.base.UploadResult;
import xin.jiangqiang.netdisc.domain.Files;
import xin.jiangqiang.netdisc.utils.UploadUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

/**
 * 本地上传
 *
 * @author jiangqiang
 * @date 2022-06-22
 */
public class COSUploadService extends AbstractUploadService<COSClient> {
    @Override
    @Transactional(rollbackFor = Exception.class)
    public AjaxResult singleUpload(MultipartFile file, Files fileObj) {
        UploadResult result = new UploadResult();
        // 原始文件名
        String originalFilename = file.getOriginalFilename();
        // 返回新文件名称，服务器上唯一
        String fileName = UploadUtils.genKey(originalFilename);
        try {
            File uploadDir = qianYiConfig.getUploadDir();//文件上传根目录 todo 需要判断是否上传到本地
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            file.transferTo(Paths.get(FileUtil.file(uploadDir, fileName).getAbsolutePath()));
            result.addSuccessFile(originalFilename, UploadUtils.getAccessUrl(fileName));

            String prefix = UploadUtils.getPrefix(originalFilename);
            String suffix = UploadUtils.getSuffix(originalFilename);
            fileObj.setFileName(prefix);//不包含后缀的原始文件名
            fileObj.setSuffix(suffix);
            fileObj.setSize(file.getSize());
            fileObj.setMimeType(file.getContentType());
            fileObj.setStorageId(1L);
            fileObj.setUploadPath(qianYiConfig.getUploadDir().getAbsolutePath());
            fileObj.setFileKey(fileName);
            fileObj.setIsDir(false);//不是目录
            fileObj.setParentId(-1L);
            fileObj.setIsPublic(false);
            return result.success();
        } catch (IOException e) {
            return result.error("文件[" + originalFilename + "]上传失败，错误原因：" + e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AjaxResult batchUpload(MultipartFile[] files, Files fileObj) {
        UploadResult result = new UploadResult();
        for (MultipartFile file : files) {
            // 原始文件名
            String originalFilename = file.getOriginalFilename();
            // 返回新文件名称，服务器上唯一
            String fileName = UploadUtils.genKey(originalFilename);
            try {
                file.transferTo(Paths.get(FileUtil.file(qianYiConfig.getUploadDir(), fileName).getAbsolutePath()));
                result.addSuccessFile(originalFilename, UploadUtils.getAccessUrl(fileName));

                String prefix = UploadUtils.getPrefix(originalFilename);
                String suffix = UploadUtils.getSuffix(originalFilename);
                fileObj.setFileName(prefix);//不包含后缀的原始文件名
                fileObj.setSuffix(suffix);
                fileObj.setSize(file.getSize());
                fileObj.setMimeType(file.getContentType());
                fileObj.setStorageId(1L);
                fileObj.setUploadPath(qianYiConfig.getUploadDir().getAbsolutePath());//todo 云存储时此为空
                fileObj.setFileKey(fileName);
                fileObj.setIsDir(false);//不是目录
                fileObj.setParentId(-1L);
                fileObj.setIsPublic(false);
            } catch (IOException e) {
                result.addErrFile(originalFilename);
            }
        }
        return result.success();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AjaxResult patchSingleUpload(MultipartFile file, Files fileObj) {
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AjaxResult patchBatchUpload(MultipartFile[] files, Files fileObj) {
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AjaxResult getProcess(Long fileId) {
        return null;
    }
}
