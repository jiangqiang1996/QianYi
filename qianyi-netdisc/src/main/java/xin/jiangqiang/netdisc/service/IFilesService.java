package xin.jiangqiang.netdisc.service;

import java.util.List;
import com.baomidou.mybatisplus.extension.service.IService;
import xin.jiangqiang.netdisc.domain.Files;

/**
 * 文件Service接口
 *
 * @author JiangQiang
 * @date 2022-06-22
 */
public interface IFilesService extends IService<Files>
{

    /**
     * 查询文件列表
     *
     * @param files 文件
     * @return 文件集合
     */
    List<Files> selectFilesList(Files files);

}
