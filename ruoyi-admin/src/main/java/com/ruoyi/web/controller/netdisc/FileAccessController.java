package com.ruoyi.web.controller.netdisc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 文件访问
 *
 * @author jiangqiang
 * @date 2022-06-21
 */
@Controller
@RequestMapping("/net-disk")
public class FileAccessController {

    /**
     * 访问文件
     *
     * @param key
     */
    @GetMapping("/access/{key}")
    public void accessFile(@PathVariable(value = "key") Long key, @RequestParam String token) {

    }

    @GetMapping("/getAccessURL")
    public void accessFile(Long key) {

    }
}
