package com.ruoyi.web.controller.netdisc;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import xin.jiangqiang.netdisc.domain.Files;
import xin.jiangqiang.netdisc.service.IFilesService;

import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

/**
 * 文件Controller
 *
 * @author JiangQiang
 * @date 2022-06-22
 */
@RestController
@RequestMapping("/net-disc/files")
public class FilesController extends BaseController
{
    @Autowired
    private IFilesService filesService;

    /**
     * 查询文件列表
     */
    @PreAuthorize("@ss.hasPermi('netdisc:files:list')")
    @GetMapping("/list")
    public TableDataInfo list(Files files)
    {
        startPage();
        List<Files> list = filesService.selectFilesList(files);
        return getDataTable(list);
    }

    /**
     * 导出文件列表
     */
    @PreAuthorize("@ss.hasPermi('netdisc:files:export')")
    @Log(title = "文件", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Files files)
    {
        List<Files> list = filesService.selectFilesList(files);
        ExcelUtil<Files> util = new ExcelUtil<Files>(Files.class);
        util.exportExcel(response, list, "文件数据");
    }

    /**
     * 获取文件详细信息
     */
    @PreAuthorize("@ss.hasPermi('netdisc:files:query')")
    @GetMapping(value = "/{fileId}")
    public AjaxResult getInfo(@PathVariable("fileId") Long fileId) {
        return AjaxResult.success(filesService.getById(fileId));
    }

    /**
     * 新增文件
     */
    @PreAuthorize("@ss.hasPermi('netdisc:files:add')")
    @Log(title = "文件", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Files files) {
        return toAjax(filesService.save(files));
    }

    /**
     * 修改文件
     */
    @PreAuthorize("@ss.hasPermi('netdisc:files:edit')")
    @Log(title = "文件", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Files files) {
        return toAjax(filesService.updateById(files));
    }

    /**
     * 删除文件
     */
    @PreAuthorize("@ss.hasPermi('netdisc:files:remove')")
    @Log(title = "文件", businessType = BusinessType.DELETE)
    @DeleteMapping("/{fileIds}")
    public AjaxResult remove(@PathVariable Long[] fileIds) {
        return toAjax(filesService.removeByIds(Arrays.asList(fileIds)));
    }
}
