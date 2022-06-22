package xin.jiangqiang;

import com.ruoyi.RuoYiApplication;
import com.ruoyi.generator.config.GenConfig;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @author jiangqiang
 * @date 2022-06-22
 */

@RunWith(SpringRunner.class)
//此处classes内的内容是@SpringBootApplication入口
@SpringBootTest(classes = {RuoYiApplication.class})

public class Test1 {
    @Autowired
    GenConfig genConfig;

    @Test
    public void test() {
        System.out.println(genConfig.isAutoRemovePre());
    }
}
