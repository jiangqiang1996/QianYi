package xin.jiangqiang.netdisc.base;

import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.web.multipart.MultipartFile;
import xin.jiangqiang.netdisc.domain.dto.FileDto;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
public interface BaseUploadService {
    /**
     * 通用上传接口
     * 不支持分片，支持一次请求上传多个文件，上传目录时不会保持原有目录结构
     * 文件夹中的所有子文件都会上传到id为parentId的目录中
     *
     * @param files     文件列表
     * @param storageId 存储方式
     * @param parentId  父级目录id
     * @return
     */
    default AjaxResult upload(MultipartFile[] files, Long storageId, Long parentId) {
        return null;
    }

    /**
     * 一次请求只能上传一个文件，支持分片上传
     *
     * @param file
     * @param chunkNumber
     * @param currentChunkSize
     * @param fileDto
     * @return
     */
    default AjaxResult patchUpload(MultipartFile file, Long chunkNumber, Long currentChunkSize, FileDto fileDto) {
        return null;
    }

    /**
     * 测试分片是否存在，用于快速上传
     *
     * @param chunkNumber
     * @param currentChunkSize
     * @param fileDto
     * @return
     */
    default AjaxResult testChunks(Long chunkNumber, Long currentChunkSize, FileDto fileDto) {
        return null;
    }

    /**
     * 合并分片接口
     *
     * @param fileDto
     * @return
     */
    default AjaxResult mergeFile(FileDto fileDto) {
        return null;
    }

}
