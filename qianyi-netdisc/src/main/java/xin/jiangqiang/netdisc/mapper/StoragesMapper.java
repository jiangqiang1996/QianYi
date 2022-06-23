package xin.jiangqiang.netdisc.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import xin.jiangqiang.netdisc.domain.Storages;

import java.util.List;

/**
 * 存储类型Mapper接口
 *
 * @author JiangQiang
 * @date 2022-06-23
 */
public interface StoragesMapper extends BaseMapper<Storages> {
    /**
     * 查询存储类型列表
     *
     * @param storages 存储类型
     * @return 存储类型集合
     */
    List<Storages> selectStoragesList(Storages storages);

}
