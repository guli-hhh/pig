/*
 * Copyright (c) 2020 pig4cloud Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.pig4cloud.pig.admin.service.impl;

import cn.hutool.core.util.ArrayUtil;
import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import com.pig4cloud.pig.admin.api.dto.SysLogDTO;
import com.pig4cloud.pig.admin.api.entity.SysLog;
import com.pig4cloud.pig.admin.mapper.SysLogMapper;
import com.pig4cloud.pig.admin.service.SysLogService;
import org.springframework.stereotype.Service;

import java.util.List;

import static com.pig4cloud.pig.admin.api.entity.table.SysLogTableDef.SYS_LOG;

/**
 * <p>
 * 日志表 服务实现类
 * </p>
 *
 * @author lengleng
 * @since 2019/2/1
 */
@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements SysLogService {

	@Override
	public Page getLogByPage(Page page, SysLogDTO sysLog) {
		return this.page(page, buildQueryWrapper(sysLog));
	}

	/**
	 * 列表查询日志
	 *
	 * @param sysLog 查询条件
	 * @return List
	 */
	@Override
	public List getLogList(SysLogDTO sysLog) {
		return mapper.selectListByQuery(buildQueryWrapper(sysLog));
	}

	/**
	 * 构建查询的 wrapper
	 *
	 * @param sysLog 查询条件
	 * @return LambdaQueryWrapper
	 */
	private QueryWrapper buildQueryWrapper(SysLogDTO sysLog) {
		QueryWrapper wrapper = QueryWrapper.create()
				.where(SYS_LOG.TYPE.eq(sysLog.getType())).and(SYS_LOG.REMOTE_ADDR.like(sysLog.getRemoteAddr()));
		if (ArrayUtil.isNotEmpty(sysLog.getCreateTime())) {
			wrapper.and(SYS_LOG.CREATE_TIME.ge(sysLog.getCreateTime()[0]))
					.and(SYS_LOG.CREATE_TIME.le(sysLog.getCreateTime()[1]));
		}
		return wrapper;
	}

}
