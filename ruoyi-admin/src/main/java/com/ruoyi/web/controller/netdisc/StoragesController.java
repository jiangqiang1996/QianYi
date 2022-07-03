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
import xin.jiangqiang.netdisc.domain.Storages;
import xin.jiangqiang.netdisc.service.IStoragesService;

import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

/**
 * 存储类型Controller
 *
 * @author JiangQiang
 * @date 2022-06-23
 */
@RestController
@RequestMapping("/net-disc/storages")
public class StoragesController extends BaseController {
    @Autowired
    private IStoragesService storagesService;

    /**
     * 查询存储类型列表
     */
    @PreAuthorize("@ss.hasPermi('netdisc:storages:list')")
    @GetMapping("/list")
    public TableDataInfo list(Storages storages) {
        startPage();
        List<Storages> list = storagesService.selectStoragesList(storages);
        return getDataTable(list);
    }

    /**
     * 导出存储类型列表
     */
    @PreAuthorize("@ss.hasPermi('netdisc:storages:export')")
    @Log(title = "存储类型", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Storages storages) {
        List<Storages> list = storagesService.selectStoragesList(storages);
        ExcelUtil<Storages> util = new ExcelUtil<Storages>(Storages.class);
        util.exportExcel(response, list, "存储类型数据");
    }

    /**
     * 获取存储类型详细信息
     */
    @PreAuthorize("@ss.hasPermi('netdisc:storages:query')")
    @GetMapping(value = "/{storageId}")
    public AjaxResult getInfo(@PathVariable("storageId") Long storageId) {
        return AjaxResult.success(storagesService.getById(storageId));
    }

    /**
     * 新增存储类型
     */
    @PreAuthorize("@ss.hasPermi('netdisc:storages:add')")
    @Log(title = "存储类型", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Storages storages) {
        return toAjax(storagesService.save(storages));
    }

    /**
     * 修改存储类型
     */
    @PreAuthorize("@ss.hasPermi('netdisc:storages:edit')")
    @Log(title = "存储类型", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Storages storages) {
        return toAjax(storagesService.updateById(storages));
    }

    /**
     * 删除存储类型
     */
    @PreAuthorize("@ss.hasPermi('netdisc:storages:remove')")
    @Log(title = "存储类型", businessType = BusinessType.DELETE)
    @DeleteMapping("/{storageIds}")
    public AjaxResult remove(@PathVariable Long[] storageIds) {
        return toAjax(storagesService.removeByIds(Arrays.asList(storageIds)));
    }
}
