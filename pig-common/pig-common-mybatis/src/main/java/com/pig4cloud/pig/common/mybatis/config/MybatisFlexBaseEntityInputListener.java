package com.pig4cloud.pig.common.mybatis.config;

import com.mybatisflex.annotation.InsertListener;
import com.mybatisflex.annotation.UpdateListener;
import com.pig4cloud.pig.common.mybatis.base.BaseEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Optional;

/**
 * MybatisPlus 自动填充配置
 *
 * @author Oliver
 * @date:  2023-8-16
 */
@Slf4j
public class MybatisFlexBaseEntityInputListener implements InsertListener, UpdateListener {

	@Override
	public void onInsert(Object entity) {
		log.debug("mybatis flex start insert fill ...." );
		BaseEntity baseEntity = (BaseEntity) entity;
		baseEntity.setCreateBy(this.getUserName());
		baseEntity.setUpdateBy(this.getUserName());
//		baseEntity.setIsDeleted(DEFAULT_DELETED_STATUS);
		//自动插入租户id
//		baseEntity.setTenantId(ObjectUtil.isNotNull(user) ? user.getTenantId() : DEFAULT_TENANT_ID);
	}

	@Override
	public void onUpdate(Object entity) {
		log.debug("mybatis flex start update fill ...." );
		BaseEntity baseEntity = (BaseEntity) entity;
		baseEntity.setUpdateBy(this.getUserName());

	}

	/**
	 * 获取 spring security 当前的用户名
	 * @return 当前用户名
	 */
	private String getUserName() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (Optional.ofNullable(authentication).isPresent()) {
			return authentication.getName();
		}
		return null;
	}
}
