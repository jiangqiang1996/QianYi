package xin.jiangqiang.netdisc.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import xin.jiangqiang.netdisc.domain.Files;

/**
 * 文件Mapper接口
 *
 * @author JiangQiang
 * @date 2022-06-22
 */
public interface FilesMapper extends BaseMapper<Files>
{
    /**
     * 查询文件列表
     *
     * @param files 文件
     * @return 文件集合
     */
    List<Files> selectFilesList(Files files);

}
