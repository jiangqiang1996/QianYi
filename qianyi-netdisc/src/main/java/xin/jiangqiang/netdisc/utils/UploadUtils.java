package xin.jiangqiang.netdisc.utils;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.RandomUtil;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
public class UploadUtils {
    /**
     * 根据原文件名生成服务器端存放的文件名，不可重复
     *
     * @param fileName
     * @return
     */
    public static String genKey(String fileName) {
        String randomNumbers = RandomUtil.randomNumbers(5);//只包含数字并且长度为5的字符串
        return DateUtil.current() + randomNumbers + "." + FileUtil.getSuffix(fileName);
    }

    public static String genKey(MultipartFile file) {
        return genKey(file.getOriginalFilename());
    }

    public static String genKey(File file) {
        return genKey(file.getName());
    }

    public static String getAccessUrl(String key) {

        return key;
    }
}
