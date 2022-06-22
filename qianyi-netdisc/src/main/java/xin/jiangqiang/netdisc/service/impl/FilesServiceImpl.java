package xin.jiangqiang.netdisc.service.impl;

import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import xin.jiangqiang.netdisc.mapper.FilesMapper;
import xin.jiangqiang.netdisc.domain.Files;
import xin.jiangqiang.netdisc.service.IFilesService;

/**
 * 文件Service业务层处理
 *
 * @author JiangQiang
 * @date 2022-06-22
 */
@Service
public class FilesServiceImpl extends ServiceImpl<FilesMapper, Files> implements IFilesService
{


    /**
     * 查询文件列表
     *
     *
     * @param files 文件
     * @return 文件
     */
    @Override
    public List<Files> selectFilesList(Files files)
    {
        return baseMapper.selectFilesList(files);
    }

}
