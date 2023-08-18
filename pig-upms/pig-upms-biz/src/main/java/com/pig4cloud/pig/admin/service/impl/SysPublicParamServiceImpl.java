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

package com.pig4cloud.pig.admin.service.impl;

import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import com.pig4cloud.pig.admin.api.entity.SysPublicParam;
import com.pig4cloud.pig.admin.mapper.SysPublicParamMapper;
import com.pig4cloud.pig.admin.service.SysPublicParamService;
import com.pig4cloud.pig.common.core.constant.CacheConstants;
import com.pig4cloud.pig.common.core.constant.enums.DictTypeEnum;
import com.pig4cloud.pig.common.core.exception.ErrorCodes;
import com.pig4cloud.pig.common.core.util.MsgUtils;
import com.pig4cloud.pig.common.core.util.R;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import static com.pig4cloud.pig.admin.api.entity.table.SysPublicParamTableDef.SYS_PUBLIC_PARAM;

/**
 * 公共参数配置
 *
 * @author Lucky
 * @date: 2019-04-29
 */
@Service
@AllArgsConstructor
public class SysPublicParamServiceImpl extends ServiceImpl<SysPublicParamMapper, SysPublicParam>
		implements SysPublicParamService {

	@Override
	@Cacheable(value = CacheConstants.PARAMS_DETAILS, key = "#publicKey", unless = "#result == null ")
	public String getSysPublicParamKeyToValue(String publicKey) {
		SysPublicParam sysPublicParam = mapper
				.selectOneByQuery(QueryWrapper.create().where(SYS_PUBLIC_PARAM.PUBLIC_KEY.eq(publicKey)));
		if (sysPublicParam != null) {
			return sysPublicParam.getPublicValue();
		}
		return null;
	}

	/**
	 * 更新参数
	 *
	 * @param sysPublicParam 参数
	 * @return R<Object>
	 */
	@Override
	@CacheEvict(value = CacheConstants.PARAMS_DETAILS, key = "#sysPublicParam.publicKey" )
	public R<Object> updateParam(SysPublicParam sysPublicParam) {
		SysPublicParam param = this.getById(sysPublicParam.getPublicId());
		// 系统内置
		if (DictTypeEnum.SYSTEM.getType().equals(param.getSystemFlag())) {
			return R.failed(MsgUtils.getMessage(ErrorCodes.SYS_PARAM_DELETE_SYSTEM));
		}
		return R.ok(this.updateById(sysPublicParam));
	}

	/**
	 * 删除参数
	 *
	 * @param publicId 参数id
	 * @return R
	 */
	@Override
	@CacheEvict(value = CacheConstants.PARAMS_DETAILS, allEntries = true)
	public R<Object> removeParam(Long publicId) {
		SysPublicParam param = this.getById(publicId);
		// 系统内置
		if (DictTypeEnum.SYSTEM.getType().equals(param.getSystemFlag())) {
			return R.failed("系统内置参数不能删除" );
		}
		return R.ok(this.removeById(publicId));
	}

	/**
	 * 同步缓存
	 *
	 * @return R
	 */
	@Override
	@CacheEvict(value = CacheConstants.PARAMS_DETAILS, allEntries = true)
	public R<Object> syncParamCache() {
		return R.ok();
	}

}
