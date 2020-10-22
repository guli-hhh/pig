/*
 *    Copyright (c) 2018-2025, lengleng All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * Neither the name of the pig4cloud.com developer nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 * Author: lengleng (wangiegie@gmail.com)
 */

package com.sf.cloud.task.task.controller;

import com.pig4cloud.pig.common.core.util.R;
import com.pig4cloud.pig.common.log.annotation.SysLog;
import com.sf.cloud.task.task.domain.po.Handler;
import com.sf.cloud.task.task.domain.vo.HandlerDicVo;
import com.sf.cloud.task.task.service.HandlerService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;


/**
 * 处理器表
 *
 * @author tucent
 * @date 2020-09-08 15:45:58
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/handler" )
@Api(value = "handler", tags = "处理器表管理")
public class HandlerController {

    private final HandlerService handlerService;

    /**
     * 分页查询
     * @param pageable 分页对象
     * @param handler 处理器表
     * @return
     */
    @ApiOperation(value = "分页查询", notes = "分页查询")
    @GetMapping("/page" )
    @PreAuthorize("@pms.hasPermission('task_handler_get')" )
    public R getHandlerPage(@PageableDefault(value = 15, sort = { "id" }, direction = Sort.Direction.DESC)
                                        Pageable pageable, Handler handler) {
        return R.ok(handlerService.findAll(pageable));
    }


    /**
     * 通过id查询处理器表
     * @param id id
     * @return R
     */
    @ApiOperation(value = "通过id查询", notes = "通过id查询")
    @GetMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('task_handler_get')" )
    public R getById(@PathVariable("id" ) Long id) {
        return R.ok(handlerService.findById(id));
    }

    /**
     * 新增处理器表
     * @param handler 处理器表
     * @return R
     */
    @ApiOperation(value = "新增处理器表", notes = "新增处理器表")
    @SysLog("新增处理器表" )
    @PostMapping
    @PreAuthorize("@pms.hasPermission('task_handler_add')" )
    public R save(@RequestBody Handler handler) {
        return R.ok(handlerService.save(handler));
    }

    /**
     * 修改处理器表
     * @param handler 处理器表
     * @return R
     */
    @ApiOperation(value = "修改处理器表", notes = "修改处理器表")
    @SysLog("修改处理器表" )
    @PutMapping
    @PreAuthorize("@pms.hasPermission('task_handler_edit')" )
    public R updateById(@RequestBody Handler handler) {
        return R.ok(handlerService.save(handler));
    }

    /**
     * 通过id删除处理器表
     * @param id id
     * @return R
     */
    @ApiOperation(value = "通过id删除处理器表", notes = "通过id删除处理器表")
    @SysLog("通过id删除处理器表" )
    @DeleteMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('task_handler_del')" )
    public R removeById(@PathVariable Long id) {
        return R.ok(handlerService.deleteById(id));
    }

    /**
     * 查询处理器(用于前台下拉框使用)
     * @return R
     */
    @ApiOperation(value = "处理器数据字典(用于前台下拉框使用)", notes = "处理器据字典(用于前台下拉框使用)")
    @GetMapping("/dic" )
    public R getById(@PageableDefault(value = 20, sort = { "id" }, direction = Sort.Direction.DESC)
                             Pageable pageable) {
        Page<Handler> oldPage = handlerService.findAll(pageable);
        List<HandlerDicVo> dic = oldPage.getContent().stream()
                .map(po -> new HandlerDicVo().fromPo(po))
                .collect(Collectors.toList());
        return R.ok(dic);
    }
}
