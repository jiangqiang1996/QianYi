package com.ruoyi.web.controller.blog;

import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.Articles;
import com.ruoyi.system.service.IArticlesService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 文章新增Controller
 *
 * @author JiangQiang
 * @date 2022-06-17
 */
@RestController
@RequestMapping("/web/articles")
public class ArticlesController extends BaseController
{
    @Autowired
    private IArticlesService articlesService;

    /**
     * 查询文章新增列表
     */
    @PreAuthorize("@ss.hasPermi('web:articles:list')")
    @GetMapping("/list")
    public TableDataInfo list(Articles articles)
    {
        startPage();
        List<Articles> list = articlesService.selectArticlesList(articles);
        return getDataTable(list);
    }

    /**
     * 导出文章新增列表
     */
    @PreAuthorize("@ss.hasPermi('web:articles:export')")
    @Log(title = "文章新增", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Articles articles)
    {
        List<Articles> list = articlesService.selectArticlesList(articles);
        ExcelUtil<Articles> util = new ExcelUtil<Articles>(Articles.class);
        util.exportExcel(response, list, "文章新增数据");
    }

    /**
     * 获取文章新增详细信息
     */
    @PreAuthorize("@ss.hasPermi('web:articles:query')")
    @GetMapping(value = "/{articleId}")
    public AjaxResult getInfo(@PathVariable("articleId") Long articleId) {
        return AjaxResult.success(articlesService.getById(articleId));
    }

    /**
     * 新增文章新增
     */
    @PreAuthorize("@ss.hasPermi('web:articles:add')")
    @Log(title = "文章新增", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Articles articles) {
        return toAjax(articlesService.save(articles));
    }

    /**
     * 修改文章新增
     */
    @PreAuthorize("@ss.hasPermi('web:articles:edit')")
    @Log(title = "文章新增", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Articles articles) {
        return toAjax(articlesService.updateById(articles));
    }

    /**
     * 删除文章新增
     */
    @PreAuthorize("@ss.hasPermi('web:articles:remove')")
    @Log(title = "文章新增", businessType = BusinessType.DELETE)
    @DeleteMapping("/{articleIds}")
    public AjaxResult remove(@PathVariable Long[] articleIds) {
        return toAjax(articlesService.removeByIds(Arrays.asList(articleIds)));
    }
}
