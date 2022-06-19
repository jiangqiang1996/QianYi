package com.ruoyi.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.system.domain.Articles;
import com.ruoyi.system.mapper.ArticlesMapper;
import com.ruoyi.system.service.IArticlesService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 文章新增Service业务层处理
 *
 * @author JiangQiang
 * @date 2022-06-17
 */
@Service
public class ArticlesServiceImpl extends ServiceImpl<ArticlesMapper, Articles> implements IArticlesService {


    /**
     * 查询文章新增列表
     *
     * @param articles 文章新增
     * @return 文章新增
     */
    @Override
    public List<Articles> selectArticlesList(Articles articles) {
        return baseMapper.selectArticlesList(articles);
    }

    @Override
    public boolean save(Articles entity) {
        return super.save(entity);
    }
}
