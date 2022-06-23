package xin.jiangqiang.netdisc.service.other;

import xin.jiangqiang.netdisc.base.BaseUploadService;

import java.util.HashMap;
import java.util.Map;

/**
 * 管理文件上传方式的对象
 */
public class UploadServiceManagement {
    private final Map<Long, BaseUploadService> serviceMap = new HashMap<>();

    public void putService(Long storageId, BaseUploadService baseUploadService) {
        this.serviceMap.put(storageId, baseUploadService);
    }

    public BaseUploadService getService(Long storageId) {
        return serviceMap.get(storageId);
    }
}
