package xin.jiangqiang;

import com.ruoyi.RuoYiApplication;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import xin.jiangqiang.netdisc.base.AbstractUploadService;
import xin.jiangqiang.netdisc.service.other.UploadServiceManagement;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */

@RunWith(SpringRunner.class)
//此处classes内的内容是@SpringBootApplication入口
@SpringBootTest(classes = {RuoYiApplication.class})

public class Test1 {
    @Autowired
    UploadServiceManagement serviceManagement;

    @Test
    public void test() {
        System.out.println(serviceManagement);
        System.out.println(((AbstractUploadService)serviceManagement.getService(1L)).getQianYiConfig());
    }
}
