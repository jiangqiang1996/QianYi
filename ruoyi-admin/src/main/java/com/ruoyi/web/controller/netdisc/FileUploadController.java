package com.ruoyi.web.controller.netdisc;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import xin.jiangqiang.netdisc.base.BaseUploadService;
import xin.jiangqiang.netdisc.domain.dto.FileDto;
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

    /**
     * 文件上传，支持多个文件批量上传
     *
     * @param files     文件列表
     * @param storageId
     * @param parentId
     * @return
     */
    @PostMapping("/upload")
    public AjaxResult singleUpload(MultipartFile[] files, Long storageId, Long parentId) {
        BaseUploadService service = uploadServiceManagement.getService(storageId);
        return service.upload(files, storageId, parentId);
    }

    /**
     * 分片上传，一次只能上传一个
     *
     * @param file             文件
     * @param chunkNumber      当前分片编号
     * @param currentChunkSize 当前分片大小
     * @param fileDto          参数
     * @return
     */
    @PostMapping("/patchUpload")
    public AjaxResult patchSingleUpload(MultipartFile file, Long chunkNumber, Long currentChunkSize, FileDto fileDto) {
        BaseUploadService service = uploadServiceManagement.getService(fileDto.getStorageId());
        return service.patchUpload(file, chunkNumber, currentChunkSize, fileDto);
    }

    /**
     * 测试分片上传
     *
     * @param chunkNumber      当前分片编号
     * @param currentChunkSize 当前分片大小
     * @param fileDto          参数
     * @return
     */
    @GetMapping("/patchUpload")
    public AjaxResult testChunks(Long chunkNumber, Long currentChunkSize, FileDto fileDto) {
        BaseUploadService service = uploadServiceManagement.getService(fileDto.getStorageId());
        return service.testChunks(chunkNumber, currentChunkSize, fileDto);
    }

    /**
     * 合并分片
     *
     * @param fileDto 参数
     * @return
     */
    @PostMapping("/mergeFile")
    public AjaxResult mergeFile(@RequestBody FileDto fileDto) {
        BaseUploadService service = uploadServiceManagement.getService(fileDto.getStorageId());
        return service.mergeFile(fileDto);
    }
}
