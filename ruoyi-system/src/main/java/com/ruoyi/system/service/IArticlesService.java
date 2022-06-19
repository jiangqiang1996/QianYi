package com.ruoyi.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.system.domain.Articles;

import java.util.List;

/**
 * 文章新增Service接口
 *
 * @author JiangQiang
 * @date 2022-06-17
 */
public interface IArticlesService extends IService<Articles> {

    /**
     * 查询文章新增列表
     *
     * @param articles 文章新增
     * @return 文章新增集合
     */
    List<Articles> selectArticlesList(Articles articles);

}
