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

package com.pig4cloud.pig.admin.api.entity;

import com.mybatisflex.annotation.Column;
import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import com.mybatisflex.core.keygen.KeyGenerators;
import com.pig4cloud.pig.common.mybatis.base.BaseEntity;
import com.pig4cloud.pig.common.mybatis.config.MybatisFlexBaseEntityInputListener;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.checkerframework.checker.units.qual.C;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * <p>
 * 部门管理
 * </p>
 *
 * @author lengleng
 * @since 2019/2/1
 */
@Data
@Schema(description = "部门")
@EqualsAndHashCode(callSuper = true)
@Table(value = "sys_dept" ,
		onInsert = MybatisFlexBaseEntityInputListener.class,
		onUpdate = MybatisFlexBaseEntityInputListener.class)
public class SysDept extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@Id(keyType = KeyType.Generator, value = KeyGenerators.snowFlakeId)
	@Schema(description = "部门id")
	private Long deptId;

	/**
	 * 部门名称
	 */
	@NotBlank(message = "部门名称不能为空")
	@Schema(description = "部门名称", required = true)
	private String name;

	/**
	 * 排序
	 */
	@NotNull(message = "部门排序值不能为空")
	@Schema(description = "排序值", required = true)
	private Integer sortOrder;

	/**
	 * 父级部门id
	 */
	@Schema(description = "父级部门id")
	private Long parentId;

}
