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

import antlr.ANTLRStringBuffer;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.pig4cloud.pig.common.core.util.R;
import com.pig4cloud.pig.common.log.annotation.SysLog;
import com.sf.cloud.task.task.annotation.IdToEntity;
import com.sf.cloud.task.task.domain.po.Message;
import com.sf.cloud.task.task.domain.po.Task;
import com.sf.cloud.task.task.service.MessageService;
import com.sf.cloud.task.task.service.TaskService;
import com.sf.cloud.task.task.utils.RequestUtil;
import lombok.Value;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;


/**
 * message
 *
 * @author tuzhaoliang
 * @date 2020-09-18 08:31:22
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/message" )
@Api(value = "message", tags = "message管理")
public class MessageController {

    private final  MessageService messageService;

    private final TaskService taskService;

    /**
     * 分页查询
     * @param pageable 分页对象
     * @param message 
     * @return
     */
    @ApiOperation(value = "分页查询", notes = "分页查询")
    @GetMapping("/page" )
    @PreAuthorize("@pms.hasPermission('task_message_get')" )
    public R getMessagePage(@PageableDefault(value = 15, sort = { "id" }, direction = Sort.Direction.DESC)
                                        Pageable pageable, Message message) {
        return R.ok(messageService.findAll(pageable));
    }


    /**
     * 通过id查询message
     * @param id id
     * @return R
     */
    @ApiOperation(value = "通过id查询", notes = "通过id查询")
    @GetMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('task_message_get')" )
    public R getById(@PathVariable("id" ) Long id) {
        return R.ok(messageService.findById(id));
    }

    /**
     * 新增message
     * @param message message
     * @return R
     */
    @ApiOperation(value = "新增message", notes = "新增message")
    @SysLog("新增message" )
    @PostMapping
    @PreAuthorize("@pms.hasPermission('task_message_add')" )
    public R save(@IdToEntity Message message) {
        return R.ok(messageService.save(message));
    }

    /**
     * 客户端上报message
     *
     * @param task     task
     * @param messages messages
     * @return R
     */
    @ApiOperation(value = "客户端上报message", notes = "客户端上报message")
    @SysLog("客户端上报message")
    @PostMapping("/client")
    @PreAuthorize("@pms.hasPermission('task_message_add')")
    public R save(HttpServletRequest request/*@RequestBody Task task, @RequestBody List<String> messages*/) {
        String requestJson = RequestUtil.getJsonFromRequest(request);
        JSONObject jsonObject = JSONUtil.parseObj(requestJson.toString());
        Long taskId = jsonObject.getLong("taskId");
        final String errorMsg = "数据不全";
        if (taskId == null) {
            return R.failed(errorMsg);
        }
        Task dbTask = taskService.findById(taskId);
        if (dbTask == null) {
            return R.failed(errorMsg);
        }
        dbTask.setPreviousFireTime(LocalDateTimeUtil.now());
        taskService.save(dbTask);

        JSONArray messagesJsonArray = jsonObject.getJSONArray("messages");
        List<Message> messages = messagesJsonArray.toList(Message.class);

        messageService.saveAll(messages);

        return R.ok();
    }
    /**
     * 修改message
     * @param message message
     * @return R
     */
    @ApiOperation(value = "修改message", notes = "修改message")
    @SysLog("修改message" )
    @PutMapping
    @PreAuthorize("@pms.hasPermission('task_message_edit')" )
    public R updateById(@RequestBody Message message) {
        return R.ok(messageService.save(message));
    }

    /**
     * 通过id删除message
     * @param id id
     * @return R
     */
    @ApiOperation(value = "通过id删除message", notes = "通过id删除message")
    @SysLog("通过id删除message" )
    @DeleteMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('task_message_del')" )
    public R removeById(@PathVariable Long id) {
        return R.ok(messageService.deleteById(id));
    }

}
