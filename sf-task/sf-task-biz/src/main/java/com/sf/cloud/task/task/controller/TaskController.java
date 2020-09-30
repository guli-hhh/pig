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

import com.pig4cloud.pig.common.core.constant.SecurityConstants;
import com.pig4cloud.pig.common.core.util.R;
import com.pig4cloud.pig.common.log.annotation.SysLog;
import com.sf.cloud.task.feign.feign.RemoteUpmsService;
import com.sf.cloud.task.task.annotation.IdToEntity;
import com.sf.cloud.task.task.domain.po.Task;
import com.sf.cloud.task.task.service.TaskService;
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


/**
 * 任务表
 *
 * @author tucent
 * @date 2020-09-11 10:27:55
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/task" )
@Api(value = "task", tags = "任务表管理")
public class TaskController {

    private final  TaskService taskService;

    private final RemoteUpmsService remoteUpmsService;

    /**
     * 分页查询
     * @param pageable 分页对象
     * @param task 任务表
     * @return
     */
    @ApiOperation(value = "分页查询", notes = "分页查询")
    @GetMapping("/page" )
    @PreAuthorize("@pms.hasPermission('task_task_get')" )
    public R getTaskPage(@PageableDefault(value = 15, sort = { "id" }, direction = Sort.Direction.DESC)
                                     Pageable pageable, Task task) {
        Page<Task> data = taskService.findAll(task, pageable);
        return R.ok(data);
    }


    /**
     * 通过id查询任务表
     * @param id id
     * @return R
     */
    @ApiOperation(value = "通过id查询", notes = "通过id查询")
    @GetMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('task_task_get')" )
    public R getById(@PathVariable("id" ) Long id) {
        return R.ok(taskService.findById(id));
    }

    /**
     * 新增任务表
     * @param task 任务表
     * @return R
     */
    @ApiOperation(value = "新增任务表", notes = "新增任务表")
    @SysLog("新增任务表" )
    @PostMapping
    @PreAuthorize("@pms.hasPermission('task_task_add')" )
    public R save(@IdToEntity Task task) {
        return R.ok(taskService.save(task));
    }

    /**
     * 修改任务表
     * @param task 任务表
     * @return R
     */
    @ApiOperation(value = "修改任务表", notes = "修改任务表")
    @SysLog("修改任务表" )
    @PutMapping
    @PreAuthorize("@pms.hasPermission('task_task_edit')" )
    public R updateById(@IdToEntity Task task) {
        return R.ok(taskService.save(task));
    }

    /**
     * 通过id删除任务表
     * @param id id
     * @return R
     */
    @ApiOperation(value = "通过id删除任务表", notes = "通过id删除任务表")
    @SysLog("通过id删除任务表" )
    @DeleteMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('task_task_del')" )
    public R removeById(@PathVariable Long id) {
        return R.ok(taskService.deleteById(id));
    }

    /**
     * 通过id删除任务表
     * @return R
     */
    @ApiOperation(value = "通过type查询字典,查询本地任务/远端任务字典表", notes = "通过type查询字典,查询本地任务/远端任务字典表")
    @GetMapping("/type/local_task")
    public R getDictByType(){
        return remoteUpmsService.getDictByType("local_task", SecurityConstants.FROM);
    }

    @PostMapping("/start")
    public R startTask(@IdToEntity List<Task> task){
        taskService.startTask(task);
        return R.ok();
    }

    @DeleteMapping("/stop")
    public R stopTask(@RequestBody List<Task> task){
        taskService.stopTask(task);
        return R.ok();
    }
}
