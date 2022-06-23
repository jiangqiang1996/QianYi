package xin.jiangqiang.netdisc.config;

import com.ruoyi.common.config.QianYiConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import xin.jiangqiang.netdisc.domain.Storages;
import xin.jiangqiang.netdisc.service.IFilesService;
import xin.jiangqiang.netdisc.service.IStoragesService;
import xin.jiangqiang.netdisc.service.other.COSUploadService;
import xin.jiangqiang.netdisc.service.other.LocalUploadService;
import xin.jiangqiang.netdisc.service.other.OSSUploadService;
import xin.jiangqiang.netdisc.service.other.UploadServiceManagement;
import xin.jiangqiang.netdisc.utils.StorageUtils;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */
@Configuration
public class UploadServiceConfiguration {
    @Autowired
    protected QianYiConfig qianYiConfig;
    @Autowired
    protected IFilesService fileService;
    @Autowired
    IStoragesService storagesService;

    @Bean
    public UploadServiceManagement UploadServiceManagement() {
        UploadServiceManagement uploadServiceManagement = new UploadServiceManagement();
        for (Storages storages : storagesService.list()) {
            Long storageId = storages.getStorageId();
            Config config = storages.getStorageConfig();
            switch (storageId.intValue()) {
                case 1://本地存储
                    LocalUploadService localUploadService = new LocalUploadService();
                    localUploadService.setFileService(fileService);
                    localUploadService.setQianYiConfig(qianYiConfig);
                    localUploadService.setClient(null);
                    uploadServiceManagement.putService(storageId, localUploadService);
                    break;
                case 2://阿里云
                    if (config.isValid()) {
                        OSSUploadService ossUploadService = new OSSUploadService();
                        ossUploadService.setFileService(fileService);
                        ossUploadService.setQianYiConfig(qianYiConfig);
                        ossUploadService.setClient(StorageUtils.getOSSClient(config));
                        uploadServiceManagement.putService(storageId, ossUploadService);
                    }
                    break;
                case 3://腾讯云
                    if (config.isValid()) {
                        COSUploadService cosUploadService = new COSUploadService();
                        cosUploadService.setFileService(fileService);
                        cosUploadService.setQianYiConfig(qianYiConfig);
                        cosUploadService.setClient(StorageUtils.getCOSClient(config));
                        uploadServiceManagement.putService(storageId, cosUploadService);
                    }
            }
        }
        return uploadServiceManagement;
    }
}
