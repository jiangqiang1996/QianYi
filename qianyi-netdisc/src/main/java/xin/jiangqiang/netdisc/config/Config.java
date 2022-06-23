package xin.jiangqiang.netdisc.config;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author jiangqiang
 * @date 2022-06-23
 */
@Getter
@Setter
@ToString
public class Config {
    private String accessKeyId;
    private String accessKeySecret;
    private String endPoint;
    private String bucketName;

    public boolean isValid() {
        return !StrUtil.hasBlank(accessKeyId, accessKeySecret, endPoint, bucketName);
    }
}
