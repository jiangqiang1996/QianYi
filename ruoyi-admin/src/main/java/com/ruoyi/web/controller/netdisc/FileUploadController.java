package com.ruoyi.web.controller.netdisc;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import xin.jiangqiang.netdisc.base.BaseUploadService;
import xin.jiangqiang.netdisc.domain.Files;
import xin.jiangqiang.netdisc.service.other.UploadServiceManagement;

/**
 * 文件上传相关接口
 *
 * @author jiangqiang
 * @date 2022-06-22
 */
@RestController
@RequestMapping("/net-disc")
public class FileUploadController extends BaseController {

    @Autowired
    UploadServiceManagement uploadServiceManagement;

    @PostMapping("/singUpload")
    public AjaxResult singleUpload(MultipartFile file, Long storageId) {
        BaseUploadService service = uploadServiceManagement.getService(storageId);
        Files fileObj = new Files();
        return service.singleUpload(file, fileObj);
    }
}
