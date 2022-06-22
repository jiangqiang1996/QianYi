package xin.jiangqiang.netdisc.base;

import com.ruoyi.common.core.domain.AjaxResult;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
public class UploadResult {
    private final List<Map<String, String>> succMap = new ArrayList<>();
    private final List<String> errFiles = new ArrayList<>();

    public void addSuccessFile(String fileName, String fileUrl) {
        Map<String, String> map = new HashMap<>();
        map.put(fileName, fileUrl);
        succMap.add(map);
    }

    public void addErrFile(String fileName) {
        errFiles.add(fileName);
    }

    /**
     * 返回正常响应码
     *
     * @return
     */
    public AjaxResult success() {
        Map<String, Object> data = new HashMap<>();
        data.put("errFiles", errFiles);
        data.put("succMap", succMap);
        return AjaxResult.success(data);
    }

    /**
     * 返回错误响应码
     *
     * @param msg
     * @return
     */
    public AjaxResult error(String msg) {
        Map<String, Object> data = new HashMap<>();
        data.put("errFiles", errFiles);
        data.put("succMap", succMap);
        return AjaxResult.error(msg, data);
    }
}
