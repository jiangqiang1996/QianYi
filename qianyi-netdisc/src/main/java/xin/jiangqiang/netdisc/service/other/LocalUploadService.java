package xin.jiangqiang.netdisc.service.other;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.file.FileReader;
import cn.hutool.core.io.file.FileWriter;
import cn.hutool.core.lang.TypeReference;
import cn.hutool.crypto.digest.DigestUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ruoyi.common.core.domain.AjaxResult;
import org.springframework.web.multipart.MultipartFile;
import xin.jiangqiang.netdisc.base.AbstractUploadService;
import xin.jiangqiang.netdisc.base.UploadResult;
import xin.jiangqiang.netdisc.domain.Files;
import xin.jiangqiang.netdisc.domain.dto.FileDto;
import xin.jiangqiang.netdisc.utils.UploadUtils;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 本地上传
 *
 * @author jiangqiang
 * @date 2022-06-22
 */
public class LocalUploadService extends AbstractUploadService<Object> {
    @Override
    public AjaxResult upload(MultipartFile[] files, Long storageId, Long parentId) {
        UploadResult result = new UploadResult();
        if (files.length == 1) {//一次上传一个文件
            MultipartFile file = files[0];
            // 原始文件名
            String originalFilename = file.getOriginalFilename();
            // 返回新文件名称，服务器上唯一
            String fileName = UploadUtils.genKey(originalFilename);
            try {
                File uploadDir = qianYiConfig.getUploadDir();//文件上传根目录
                File destFile = FileUtil.file(uploadDir, fileName);
                file.transferTo(destFile);
                saveFile(result, file, parentId, fileName, DigestUtil.md5Hex(destFile));
                return result.success();
            } catch (IOException e) {
                return result.error("文件[" + originalFilename + "]上传失败，失败原因：" + e.getMessage());
            }
        } else {//上传多个文件时，一个文件失败不会报错
            for (MultipartFile file : files) {
                // 原始文件名
                String originalFilename = file.getOriginalFilename();
                // 返回新文件名称，服务器上唯一
                String fileName = UploadUtils.genKey(originalFilename);
                try {
                    File destFile = FileUtil.file(qianYiConfig.getUploadDir(), fileName);
                    file.transferTo(destFile);
                    saveFile(result, file, parentId, fileName, DigestUtil.md5Hex(destFile));
                } catch (IOException e) {
                    result.addErrFile(originalFilename);
                }
            }
            return result.success();
        }
    }

    /**
     * 保存文件数据到数据库
     *
     * @param result
     * @param file
     * @param parentId
     * @param key
     */
    private void saveFile(UploadResult result, MultipartFile file, Long parentId, String key, String identifier) {
        Files fileObj = new Files();
        fileObj.setMimeType(file.getContentType());
        fileObj.setSize(file.getSize());
        save(result, fileObj, file.getOriginalFilename(), parentId, key, identifier);
    }

    @Override
    public AjaxResult patchUpload(MultipartFile file, Long chunkNumber, Long currentChunkSize, FileDto fileDto) {
        UploadResult result = new UploadResult();
        // 原始文件名
        String originalFilename = file.getOriginalFilename();
        try {
            if (fileDto.getTotalChunks() == 1) {//只有一片
                // 返回新文件名称，服务器上唯一
                String key = UploadUtils.genKey(originalFilename);
                File uploadDir = qianYiConfig.getUploadDir();//本地上传文件上传根目录
                file.transferTo(FileUtil.file(uploadDir, key));
                Long parentId = mkParentDir(fileDto);
                Files fileObj = new Files();
                fileObj.setMimeType(file.getContentType());
                fileObj.setSize(file.getSize());
                save(result, fileObj, originalFilename, parentId, key, fileDto.getIdentifier());
            } else {
                File cacheDir = qianYiConfig.getCacheDir();//全局缓存目录
                File tmpFileDir = FileUtil.file(cacheDir, UploadUtils.getTmpDirName(fileDto.getIdentifier(), fileDto.getTotalSize()));//该文件上传时临时存储目录
                UploadUtils.mkdirIfNot(tmpFileDir);
                File destFile = FileUtil.file(tmpFileDir, chunkNumber + "");
                if (!destFile.exists() || destFile.length() != currentChunkSize) {//分片不存在或分片大小不一致
                    file.transferTo(destFile);
                }
                result.setNeedMerge(true);
                if (Objects.equals(chunkNumber, fileDto.getTotalChunks())) {//判断是否为最后一片，只需要缓存一次元数据文件
                    FileWriter fileWriter = new FileWriter((FileUtil.file(tmpFileDir, "metaData.txt")));
                    Map<String, String> map = new HashMap<>();
                    map.put("fileName", file.getOriginalFilename());
                    map.put("mimeType", file.getContentType());
                    map.put("parentId", String.valueOf(fileDto.getParentId()));//上传文件夹时为最顶层文件夹的父级目录
                    map.put("storageId", String.valueOf(fileDto.getStorageId()));
                    map.put("randomKey", fileDto.getRandomKey());
                    fileWriter.write(JSONUtil.toJsonPrettyStr(map));
                }
            }
            return result.success();
        } catch (IOException e) {
            result.addErrFile(originalFilename);
            return result.error("文件[" + originalFilename + "]上传失败，错误原因：" + e.getMessage());
        }
    }

    @Override
    public AjaxResult testChunks(Long chunkNumber, Long currentChunkSize, FileDto fileDto) {
        UploadResult result = new UploadResult();
        /*查询数据库中，是否已经存在完整的文件*/
        QueryWrapper<Files> queryWrapper = new QueryWrapper<>();
        /*在同一目录下，以下查询条件唯一*/
        queryWrapper.eq("identifier", fileDto.getIdentifier());
        queryWrapper.eq("size", fileDto.getTotalSize());
        queryWrapper.eq("storage_id", fileDto.getStorageId());
        List<Files> filesList = getFileService().list(queryWrapper);//不同目录中可能存在同一文件，所以此处可能是多个结果
        if (CollUtil.isNotEmpty(filesList)) {
            String relativePath = fileDto.getRelativePath();
            if (fileDto.getFileName().equals(relativePath)) {//上传文件到指定目录
                List<Map<String, Long>> mapList = filesList.stream().map(file -> {
                    Map<String, Long> map = new HashMap<>();
                    map.put(file.getFileName() + "." + file.getSuffix(), file.getParentId());
                    return map;
                }).collect(Collectors.toList());
                for (Map<String, Long> tmpMap : mapList) {//判断是否在同一目录中，并且文件名相同
                    if (fileDto.getParentId().equals(tmpMap.get(fileDto.getFileName()))) {
                        return result.success();
                    }
                }
            }
            /*上传文件夹到指定目录*/
            List<String> parentDirNameList = UploadUtils.getParentDirName(relativePath);
            Long parentId = fileDto.getParentId();
            for (int i = 0; i < parentDirNameList.size(); i++) {
                String tmpDirName = parentDirNameList.get(i);
                /*根据文件名查询是否存在目录*/
                QueryWrapper<Files> filesQueryWrapper = new QueryWrapper<>();
                filesQueryWrapper.eq("parent_id", parentId);
                filesQueryWrapper.eq("file_name", tmpDirName);
                filesQueryWrapper.eq("storage_id", fileDto.getStorageId());
                filesQueryWrapper.eq("is_dir", 1);
                Files tmpDir = getFileService().getOne(filesQueryWrapper);
                if (tmpDir != null) {
                    parentId = tmpDir.getFileId();
                } else {
                    Files one = filesList.get(0);
                    Files fileObj = new Files();
                    fileObj.setParentId(parentId);
                    fileObj.setIdentifier(fileObj.getIdentifier());
                    String prefix = UploadUtils.getPrefix(fileDto.getFileName());
                    String suffix = UploadUtils.getSuffix(fileDto.getFileName());
                    fileObj.setFileName(prefix);//不包含后缀的原始文件名
                    fileObj.setSuffix(suffix);
                    fileObj.setStorageId(1L);
                    fileObj.setUploadPath(one.getUploadPath());
                    fileObj.setFileKey(one.getFileKey());
                    fileObj.setIsDir(one.getIsDir());//不是目录
                    fileObj.setIsPublic(false);
                    fileObj.setSize(one.getSize());
                    fileObj.setIdentifier(one.getIdentifier());
                    fileObj.setMimeType(one.getMimeType());
                    result.setNeedMerge(false);
                    getFileService().save(fileObj);
                    result.addSuccessFile(fileDto.getFileName(), UploadUtils.getAccessUrl(fileObj.getFileKey()));
                }
            }
            return result.success();
        } else {
            /*查询文件分片是否存在*/
            if (fileDto.getTotalChunks() != 1) {//只有一片时，没有临时文件，所以只查询分片数量不为1的
                File tmpFileDir = FileUtil.file(qianYiConfig.getCacheDir(), UploadUtils.getTmpDirName(fileDto.getIdentifier(), fileDto.getTotalSize()));//该文件上传时临时存储目录
                File destFile = FileUtil.file(tmpFileDir, chunkNumber + "");
                if (destFile.exists() && destFile.length() == currentChunkSize) {
                    return result.success();
                }
            }
        }
        return result.error("快速上传失败");
    }

    @Override
    public AjaxResult mergeFile(FileDto fileDto) {
        UploadResult result = new UploadResult();
        File tmpFileDir = FileUtil.file(qianYiConfig.getCacheDir(), UploadUtils.getTmpDirName(fileDto.getIdentifier(), fileDto.getTotalSize()));//该文件上传时临时存储目录
        String fileName = UploadUtils.genKey(fileDto.getFileName());
        File uploadDir = qianYiConfig.getUploadDir();//文件上传根目录
        File file = FileUtil.file(uploadDir, fileName);//最终生成的文件File对象
        FileWriter fileWriter = new FileWriter(file);
        for (int i = 1; i <= fileDto.getTotalChunks(); i++) {
            File tmpFile = FileUtil.file(tmpFileDir, String.valueOf(i));
            if (tmpFile.length() == fileDto.getChunkSize() || i == fileDto.getTotalChunks()) {
                FileReader fileReader = new FileReader(tmpFile);
                byte[] bytes = fileReader.readBytes();
                fileWriter.append(bytes, 0, bytes.length);
            } else {
                result.addErrFile(fileDto.getFileName());
                result.setErrMsg("文件上传失败");
                break;
            }
        }
        if (null == result.getErrMsg()) {
            Files fileObj = new Files();
            fileObj.setSize(fileDto.getTotalSize());
            Map<String, String> map = getMetaDataMap(tmpFileDir);
            fileObj.setMimeType(map.get("mimeType"));
            Long parentId;
            if (fileDto.getFileName().equals(fileDto.getRelativePath())) {
                parentId = fileDto.getParentId();
            } else {
                parentId = mkParentDir(fileDto);
            }
            save(result, fileObj, fileDto.getFileName(), parentId, fileName, fileDto.getIdentifier());
        }
        return result.toResult();
    }

    private Map<String, String> getMetaDataMap(File tmpFileDir) {
        FileReader fileReader = new FileReader(FileUtil.file(tmpFileDir, "metaData.txt"));
        JSONObject jsonObject = JSONUtil.parseObj(fileReader.readString());
        return jsonObject.toBean(new TypeReference<>() {
        });
    }

    /**
     * 如果文件名重复，会自动处理文件名
     *
     * @param result
     * @param fileObj
     * @param originalFilename
     * @param parentId
     * @param key
     */
    private synchronized void save(UploadResult result, Files fileObj, String originalFilename, Long parentId, String key, String identifier) {
        String prefix = UploadUtils.getPrefix(originalFilename);
        String suffix = UploadUtils.getSuffix(originalFilename);
        for (int i = 0; ; i++) {
            QueryWrapper<Files> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("parent_id", parentId);
            queryWrapper.eq("suffix", suffix);
            String newFileName;
            if (i == 0) {
                newFileName = prefix;
            } else {
                newFileName = prefix + "(" + i + ")";
            }
            queryWrapper.eq("file_name", newFileName);
            if (getFileService().getOne(queryWrapper) == null) {
                fileObj.setParentId(parentId);
                fileObj.setIdentifier(identifier);
                fileObj.setFileName(newFileName);//不包含后缀的原始文件名
                fileObj.setSuffix(suffix);
                fileObj.setStorageId(1L);
                fileObj.setUploadPath(qianYiConfig.getUploadDir().getAbsolutePath());
                fileObj.setFileKey(key);
                fileObj.setIsDir(false);//不是目录
                fileObj.setIsPublic(false);
                result.setNeedMerge(false);
                getFileService().save(fileObj);
                result.addSuccessFile(originalFilename, UploadUtils.getAccessUrl(key));
                break;
            }
        }
    }

    /**
     * 生成父级目录
     *
     * @param fileDto
     * @return
     */
    private synchronized Long mkParentDir(FileDto fileDto) {
        String relativePath = fileDto.getRelativePath();
        List<String> parentDirNameList = UploadUtils.getParentDirName(relativePath);
        Long parentId = fileDto.getParentId();//存储父级id
        for (int i = 0; i < parentDirNameList.size(); i++) {//同一个目录下文件名不可重复
            String parentDirName = parentDirNameList.get(i);//当前目录名字
            if (i == 0) {//最顶层目录
                //通过key查询是否存在，已经存在则不再创建，key有值时不可以重复，此时可以作为文件的唯一标识
                QueryWrapper<Files> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("random_key", fileDto.getRandomKey());
                Files one = getFileService().getOne(queryWrapper);
                if (one != null) {//存在，则跳过此次循环
                    parentId = one.getFileId();
                } else {
                    /*不存在，则根据名字查询，作用是自动命名，文件存在，则修改文件名重新查询*/
                    for (int j = 0; ; j++) {
                        QueryWrapper<Files> selectQuery = new QueryWrapper<>();
                        selectQuery.eq("parent_id", parentId);
                        selectQuery.eq("suffix", "");
                        String newDirName;
                        if (j == 0) {
                            newDirName = parentDirName;
                        } else {
                            newDirName = parentDirName + "(" + j + ")";
                        }
                        selectQuery.eq("file_name", newDirName);
                        if (getFileService().getOne(selectQuery) == null) {
                            Files files = new Files();
                            files.setRandomKey(fileDto.getRandomKey());//上传文件夹时的根目录才需要设置key
                            files.setStorageId(1L);
                            files.setFileKey(UploadUtils.genKey(parentDirName));
                            files.setIsDir(true);
                            files.setParentId(parentId);
                            files.setIsPublic(false);
                            String prefix = UploadUtils.getPrefix(parentDirName);
                            String suffix = UploadUtils.getSuffix(parentDirName);
                            files.setFileName(prefix);
                            files.setSuffix(suffix);
                            getFileService().save(files);
                            parentId = files.getFileId();
                            break;
                        }
                    }
                }
            } else {
                QueryWrapper<Files> selectQuery = new QueryWrapper<>();
                selectQuery.eq("parent_id", parentId);
                selectQuery.eq("suffix", "");
                selectQuery.eq("file_name", parentDirName);
                Files one = getFileService().getOne(selectQuery);
                if (one != null) {
                    parentId = one.getFileId();
                } else {
                    Files files = new Files();
                    files.setStorageId(1L);
                    files.setFileKey(UploadUtils.genKey(parentDirName));
                    files.setIsDir(true);
                    files.setParentId(parentId);
                    files.setIsPublic(false);
                    String prefix = UploadUtils.getPrefix(parentDirName);
                    String suffix = UploadUtils.getSuffix(parentDirName);
                    files.setFileName(prefix);
                    files.setSuffix(suffix);
                    getFileService().save(files);
                    parentId = files.getFileId();
                }
            }
        }
        return parentId;
    }

}
