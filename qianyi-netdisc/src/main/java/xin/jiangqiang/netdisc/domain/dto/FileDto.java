package xin.jiangqiang.netdisc.domain.dto;

import lombok.Data;

/**
 * @author jiangqiang
 * @date 2022-06-24
 */
@Data
public class FileDto {
    /**
     * 原始文件名
     */
    private String fileName;
    /**
     * md5
     */
    private String identifier;
    /**
     * 相对路径
     */
    private String relativePath;
    /**
     * 总的分片数
     */
    private Long totalChunks;
    /**
     * 分片大小
     */
    private Long chunkSize;
    /**
     * 文件总大小
     */
    private Long totalSize;
    /**
     * 存储方式
     */
    private Long storageId;
    /**
     * 父级目录id
     */
    private Long parentId;
    /**
     * 同一个目录下，不可重复
     */
    private String randomKey;
}
