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

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.pig4cloud.pig.common.core.util.R;
import com.pig4cloud.pig.common.log.annotation.SysLog;
import com.sf.cloud.task.task.domain.po.DataSource;
import com.sf.cloud.task.task.domain.po.Project;
import com.sf.cloud.task.task.domain.vo.ProjectDicVo;
import com.sf.cloud.task.task.service.DataSourceService;
import org.springframework.data.domain.*;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;


/**
 * 数据源表
 *
 * @author tucent
 * @date 2020-09-09 11:18:30
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/datasource" )
@Api(value = "datasource", tags = "数据源表管理")
public class DataSourceController {

    private final DataSourceService dataSourceService;

    /**
     * 分页查询
     * @param pageable 分页对象
     * @param dataSource 数据源表
     * @return
     */
    @ApiOperation(value = "分页查询", notes = "分页查询")
    @GetMapping("/page" )
    @PreAuthorize("@pms.hasPermission('task_datasource_get')" )
    public R getDataSourcePage(@PageableDefault(value = 15, sort = { "id" }, direction = Sort.Direction.DESC)
                                           Pageable pageable, DataSource dataSource) {
        Page<DataSource> pageOld = dataSourceService.findAll(pageable);
//        List<DataSourceVo> result = pageOld.getContent()
//                .stream()
//                .map(po -> new DataSourceVo().fromPo(po))
//                .collect(Collectors.toList());
//        PageImpl<DataSourceVo> pageNew = PageUtil.getPage(result, pageOld);
        return R.ok(pageOld);
    }


    /**
     * 通过id查询数据源表
     * @param id id
     * @return R
     */
    @ApiOperation(value = "通过id查询", notes = "通过id查询")
    @GetMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('task_datasource_get')" )
    public R getById(@PathVariable("id" ) Long id) {
        return R.ok(dataSourceService.findById(id));
    }

    /**
     * 新增数据源表
     * @param dataSource 数据源表
     * @return R
     */
    @ApiOperation(value = "新增数据源表", notes = "新增数据源表")
    @SysLog("新增数据源表" )
    @PostMapping
    @PreAuthorize("@pms.hasPermission('task_datasource_add')" )
    public R save(@RequestBody DataSource dataSource) {
        return R.ok(dataSourceService.save(dataSource));
    }

    /**
     * 修改数据源表
     * @param dataSource 数据源表
     * @return R
     */
    @ApiOperation(value = "修改数据源表", notes = "修改数据源表")
    @SysLog("修改数据源表" )
    @PutMapping
    @PreAuthorize("@pms.hasPermission('task_datasource_edit')" )
    public R updateById(@RequestBody DataSource dataSource) {
        return R.ok(dataSourceService.save(dataSource));
    }

    /**
     * 通过id删除数据源表
     * @param id id
     * @return R
     */
    @ApiOperation(value = "通过id删除数据源表", notes = "通过id删除数据源表")
    @SysLog("通过id删除数据源表" )
    @DeleteMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('task_datasource_del')" )
    public R removeById(@PathVariable Long id) {
        return R.ok(dataSourceService.deleteById(id));
    }

    /**
     * 查询数据源(用于前台下拉框使用)
     * @return R
     */
    @ApiOperation(value = "数据源数据字典(用于前台下拉框使用)", notes = "数据源数据字典(用于前台下拉框使用)")
    @GetMapping("/dic" )
    @PreAuthorize("@pms.hasPermission('task_datasource_get')" )
    public R getById() {
        List<DataSource> dataSources = dataSourceService.findAll();
        JSONArray options = JSONUtil.createArray();
        List<JSONObject> option = dataSources.stream().map(dataSource -> {
            JSONObject obj = JSONUtil.createObj();
            obj.set("label", dataSource.getName());
            obj.set("value", dataSource.getId());
            return obj;
        }).collect(Collectors.toList());
        options.addAll(option);
        return R.ok(options);
    }
}
