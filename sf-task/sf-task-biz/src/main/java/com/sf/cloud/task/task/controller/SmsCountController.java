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
import com.sf.cloud.task.task.service.SmsCountService;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;


/**
 * 短信配置表
 *
 * @author tucent
 * @date 2020-10-10 14:54:59
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/smscount" )
@Api(value = "smscount", tags = "短信配置表管理")
public class SmsCountController {

    private final  SmsCountService smsCountService;

    /**
     * 短信剩余条数
     * @return
     */
    @ApiOperation(value = "短信剩余条数", notes = "短信剩余条数")
    @GetMapping("/remain" )
    @PreAuthorize("@pms.hasPermission('task_smscount_get')" )
    public R getSmsCountPage() {
        return R.ok(smsCountService.getRemain());
    }

    /**
     * 修改短信配置表
     * @return R
     */
    @ApiOperation(value = "修改短信配置表", notes = "修改短信配置表")
    @SysLog("修改短信配置表" )
    @PutMapping("/remain/{remainCount}")
    @PreAuthorize("@pms.hasPermission('task_smscount_edit')" )
    public R updateById(@PathVariable("remainCount") Long remainCount) {
		smsCountService.setRemain(remainCount);
        return R.ok();
    }

	/**
	 * 短信已发送条数
	 * @return
	 */
	@ApiOperation(value = "短信已发送条数", notes = "短信已发送条数")
	@GetMapping("/has_send" )
	@PreAuthorize("@pms.hasPermission('task_smscount_get')" )
	public R getSmsHasSend() {
		return R.ok(smsCountService.getHasSendCount());
	}

}
