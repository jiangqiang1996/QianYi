package xin.jiangqiang.netdisc.service;

import com.baomidou.mybatisplus.extension.service.IService;
import xin.jiangqiang.netdisc.domain.Storages;

import java.util.List;

/**
 * 存储类型Service接口
 *
 * @author JiangQiang
 * @date 2022-06-23
 */
public interface IStoragesService extends IService<Storages> {

    /**
     * 查询存储类型列表
     *
     * @param storages 存储类型
     * @return 存储类型集合
     */
    List<Storages> selectStoragesList(Storages storages);

}
