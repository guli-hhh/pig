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

/**
 * 字典表
 *
 * @author lengleng
 * @date 2019/03/19
 */
@Data
@Schema(description = "字典类型")
@EqualsAndHashCode(callSuper = true)
@Table(value = "sys_dict" ,
		onInsert = MybatisFlexBaseEntityInputListener.class,
		onUpdate = MybatisFlexBaseEntityInputListener.class)
public class SysDict extends BaseEntity {

	private static final long serialVersionUID = 1L;

	/**
	 * 编号
	 */
	@Id(keyType = KeyType.Generator, value = KeyGenerators.snowFlakeId)
	@Schema(description = "字典编号" )
	private Long id;

	/**
	 * 类型
	 */
	@Schema(description = "字典key")
	private String dictKey;

	/**
	 * 描述
	 */
	@Schema(description = "字典描述")
	private String description;

	/**
	 * 是否是系统内置
	 */
	@Schema(description = "是否系统内置")
	private String systemFlag;

	/**
	 * 备注信息
	 */
	@Schema(description = "备注信息")
	private String remark;

}
