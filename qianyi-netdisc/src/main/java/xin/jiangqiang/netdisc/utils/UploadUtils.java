package xin.jiangqiang.netdisc.utils;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.CharUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
public class UploadUtils {
    /**
     * 根据原文件名生成服务器端存放的文件名，不可重复
     *
     * @param fileName 文件名
     * @return 时间戳+随机数+[.文件后缀名]
     */
    public static String genKey(String fileName) {
        String randomNumbers = RandomUtil.randomNumbers(5);//只包含数字并且长度为5的字符串
        if (StrUtil.isBlank(fileName)) {
            return DateUtil.current() + randomNumbers;
        }
        String suffix = FileUtil.getSuffix(fileName);
        if (StrUtil.isBlank(suffix)) {
            return DateUtil.current() + randomNumbers;
        } else {
            return DateUtil.current() + randomNumbers + "." + FileUtil.getSuffix(fileName);
        }
    }

    public static String genKey(MultipartFile file) {
        return genKey(file.getOriginalFilename());
    }

    public static String genKey(File file) {
        return genKey(file.getName());
    }

    /**
     * 获取访问链接
     *
     * @param key
     * @return
     */
    public static String getAccessUrl(String key) {

        return key;
    }

    /**
     * 获取文件名后缀
     *
     * @param fileName
     * @return
     */

    public static String getSuffix(String fileName) {
        return FileUtil.getSuffix(fileName);
    }

    /**
     * 获取文件名，不包含后缀
     *
     * @param fileName
     * @return
     */
    public static String getPrefix(String fileName) {
        return FileUtil.getPrefix(fileName);
    }

    /**
     * 目录补存在则创建
     *
     * @param file
     */
    public static void mkdirIfNot(File file) {
        if (!file.exists()) {
            file.mkdirs();
        }
    }

    public static void mkdirIfNot(String path) {
        mkdirIfNot(FileUtil.file(path));
    }

    /**
     * 分片文件缓存目录，保证唯一识别码和文件大小相等的情况下，三十天内获取到的文件名是一致的
     *
     * @param identifier md5或其他唯一识别码
     * @param totalSize  文件总大小
     * @return
     */
    public static String getTmpDirName(String identifier, Long totalSize) {
        long time = System.currentTimeMillis() / 1000 / 3600 / 24 / 30;
        return time + identifier + totalSize;
    }

    /**
     * 解析出该相对路径的父级目录名字
     *
     * @param relativePath
     * @return
     */
    public static List<String> getParentDirName(String relativePath) {
        if (StrUtil.isBlank(relativePath)) {
            return null;
        }
        if (CharUtil.isFileSeparator(relativePath.charAt(0))) {
            relativePath = relativePath.substring(1);
        }
        int len = relativePath.length();
        if (CharUtil.isFileSeparator(relativePath.charAt(len - 1))) {
            // 以分隔符结尾的去掉结尾分隔符
            len--;
        }
        int begin = 0;
        List<String> list = new ArrayList<>();
        for (int i = 0; i < len; i++) {
            char c = relativePath.charAt(i);
            if (CharUtil.isFileSeparator(c)) {
                // 查找最后一个路径分隔符（/或者\）
                list.add(relativePath.substring(begin, i));
                begin = i + 1;
            }
        }
        return list;
    }

}
