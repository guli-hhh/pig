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

import com.pig4cloud.pig.admin.api.feign.RemoteUserService;
import com.pig4cloud.pig.common.core.util.R;
import com.pig4cloud.pig.common.log.annotation.SysLog;
import com.sf.cloud.task.feign.feign.RemoteUpmsService;
import com.sf.cloud.task.task.domain.po.Project;
import com.sf.cloud.task.task.domain.vo.ProjectDicVo;
import com.sf.cloud.task.task.service.ProjectService;
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
 * 项目分组表
 *
 * @author tucent
 * @date 2020-09-08 17:23:57
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/project" )
@Api(value = "group", tags = "项目分组表管理")
public class ProjectController {

    private final ProjectService projectService;

    /**
     * 分页查询
     * @param pageable 分页对象
     * @param project 项目分组表
     * @return
     */
    @ApiOperation(value = "分页查询", notes = "分页查询")
    @GetMapping("/page" )
    @PreAuthorize("@pms.hasPermission('task_project_get')" )
    public R getGroupPage(@PageableDefault(value = 15, sort = { "id" }, direction = Sort.Direction.DESC)
                                      Pageable pageable, Project project) {
        return R.ok(projectService.findAll(pageable));
    }


    /**
     * 通过id查询项目分组表
     * @param id id
     * @return R
     */
    @ApiOperation(value = "通过id查询", notes = "通过id查询")
    @GetMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('task_project_get')" )
    public R getById(@PathVariable("id" ) Long id) {
        return R.ok(projectService.findById(id));
    }

    /**
     * 新增项目分组表
     * @param project 项目分组表
     * @return R
     */
    @ApiOperation(value = "新增项目分组表", notes = "新增项目分组表")
    @SysLog("新增项目分组表" )
    @PostMapping
    @PreAuthorize("@pms.hasPermission('task_project_add')" )
    public R save(@RequestBody Project project) {
        return R.ok(projectService.save(project));
    }

    /**
     * 修改项目分组表
     * @param project 项目分组表
     * @return R
     */
    @ApiOperation(value = "修改项目分组表", notes = "修改项目分组表")
    @SysLog("修改项目分组表" )
    @PutMapping
    @PreAuthorize("@pms.hasPermission('task_project_edit')" )
    public R updateById(@RequestBody Project project) {
        return R.ok(projectService.save(project));
    }

    /**
     * 通过id删除项目分组表
     * @param id id
     * @return R
     */
    @ApiOperation(value = "通过id删除项目分组表", notes = "通过id删除项目分组表")
    @SysLog("通过id删除项目分组表" )
    @DeleteMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('task_project_del')" )
    public R removeById(@PathVariable Long id) {
        return R.ok(projectService.deleteById(id));
    }

    /**
     * 查询项目(用于前台下拉框使用)
     * @return R
     */
    @ApiOperation(value = "项目数据字典(用于前台下拉框使用)", notes = "项目数据字典(用于前台下拉框使用)")
    @GetMapping("/dic" )
    @PreAuthorize("@pms.hasPermission('task_project_get')" )
    public R getById(@PageableDefault(value = 20, sort = { "id" }, direction = Sort.Direction.DESC)
                                                Pageable pageable) {
        Page<Project> oldPage = projectService.findAll(pageable);
        List<ProjectDicVo> dic = oldPage.getContent().stream()
                .map(po -> new ProjectDicVo().fromPo(po))
                .collect(Collectors.toList());
        return R.ok(dic);
    }
}
