package xin.jiangqiang.netdisc.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import xin.jiangqiang.netdisc.domain.Storages;
import xin.jiangqiang.netdisc.mapper.StoragesMapper;
import xin.jiangqiang.netdisc.service.IStoragesService;

import java.util.List;

/**
 * 存储类型Service业务层处理
 *
 * @author JiangQiang
 * @date 2022-06-23
 */
@Service
public class StoragesServiceImpl extends ServiceImpl<StoragesMapper, Storages> implements IStoragesService {

    /**
     * 查询存储类型列表
     *
     * @param storages 存储类型
     * @return 存储类型
     */
    @Override
    public List<Storages> selectStoragesList(Storages storages) {
        return baseMapper.selectStoragesList(storages);
    }

}
