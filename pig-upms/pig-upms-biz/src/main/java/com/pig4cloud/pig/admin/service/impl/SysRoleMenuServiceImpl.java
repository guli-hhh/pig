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

import cn.hutool.core.util.StrUtil;
import com.mybatisflex.core.query.QueryWrapper;
import com.mybatisflex.spring.service.impl.ServiceImpl;
import com.pig4cloud.pig.admin.api.entity.SysRoleMenu;
import com.pig4cloud.pig.admin.mapper.SysRoleMenuMapper;
import com.pig4cloud.pig.admin.service.SysRoleMenuService;
import com.pig4cloud.pig.common.core.constant.CacheConstants;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.pig4cloud.pig.admin.api.entity.table.SysRoleMenuTableDef.SYS_ROLE_MENU;

/**
 * <p>
 * 角色菜单表 服务实现类
 * </p>
 *
 * @author lengleng
 * @since 2019/2/1
 */
@Service
@RequiredArgsConstructor
public class SysRoleMenuServiceImpl extends ServiceImpl<SysRoleMenuMapper, SysRoleMenu> implements SysRoleMenuService {

	private final CacheManager cacheManager;

	/**
	 * @param roleId  角色
	 * @param menuIds 菜单ID拼成的字符串，每个id之间根据逗号分隔
	 * @return Boolean
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean saveRoleMenus(Long roleId, String menuIds) {
		this.remove(QueryWrapper.create().where(SYS_ROLE_MENU.ROLE_ID.eq(roleId)));

		if (StrUtil.isBlank(menuIds)) {
			return Boolean.TRUE;
		}
		List<SysRoleMenu> roleMenuList = Arrays.stream(menuIds.split(StrUtil.COMMA)).map(menuId -> {
			SysRoleMenu roleMenu = new SysRoleMenu();
			roleMenu.setRoleId(roleId);
			roleMenu.setMenuId(Long.valueOf(menuId));
			return roleMenu;
		}).collect(Collectors.toList());

		// 清空userinfo
		Objects.requireNonNull(cacheManager.getCache(CacheConstants.USER_DETAILS)).clear();
		// 清空全部的菜单缓存 fix #I4BM58
		Objects.requireNonNull(cacheManager.getCache(CacheConstants.MENU_DETAILS)).clear();
		return this.saveBatch(roleMenuList);
	}

}
