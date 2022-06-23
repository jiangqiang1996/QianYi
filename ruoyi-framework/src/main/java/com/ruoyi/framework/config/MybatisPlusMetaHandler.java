package com.ruoyi.framework.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.ruoyi.common.utils.SecurityUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
@Slf4j
public class MybatisPlusMetaHandler implements MetaObjectHandler {
    public void insertFill(MetaObject metaObject) {
        try {
            Date time = new Date();
            if (metaObject.hasSetter("createTime")) {
                log.debug("自动插入 createTime");
                this.setFieldValByName("createTime", time, metaObject);
            }
            if (metaObject.hasSetter("createDate")) {
                log.debug("自动插入 createDate");
                this.setFieldValByName("createDate", time, metaObject);
            }
            if (metaObject.hasSetter("delFlag")) {
                log.debug("自动插入 delFlag");
                this.setFieldValByName("delFlag", "0", metaObject);
            }
            String username = SecurityUtils.getLoginUser().getUsername();
            if (metaObject.hasSetter("createBy")) {
                log.debug("自动插入 createBy");
                this.setFieldValByName("createBy", username, metaObject);
            }
        } catch (Exception e) {
            log.error("自动注入失败:{}", e.getMessage());
        }

    }

    public void updateFill(MetaObject metaObject) {
        try {
            Date time = new Date();
            if (metaObject.hasSetter("updateTime")) {
                log.debug("自动插入 updateTime");
                this.setFieldValByName("updateTime", time, metaObject);
            }
            if (metaObject.hasSetter("updateDate")) {
                log.debug("自动插入 updateDate");
                this.setFieldValByName("updateDate", time, metaObject);
            }
            String username = SecurityUtils.getLoginUser().getUsername();
            if (metaObject.hasSetter("updateBy")) {
                log.debug("自动插入 updateBy");
                this.setFieldValByName("updateBy", username, metaObject);
            }
        } catch (Exception e) {
            log.error("自动注入失败:{}", e.getMessage());
        }

    }
}
