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
package com.pig4cloud.pig.admin.api.entity;


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
 * 岗位管理
 *
 * @author fxz
 * @date 2022-03-15 17:18:40
 */
@Data
@Table(value = "sys_post" ,
		onInsert = MybatisFlexBaseEntityInputListener.class,
		onUpdate = MybatisFlexBaseEntityInputListener.class)
@EqualsAndHashCode(callSuper = true)
@Schema(description = "岗位信息表")
public class SysPost extends BaseEntity {

	private static final long serialVersionUID = -8744622014102311894L;

	/**
	 * 岗位ID
	 */
	@Id(keyType = KeyType.Generator, value = KeyGenerators.snowFlakeId)
	@Schema(description = "岗位ID" )
	private Long postId;

	/**
	 * 岗位编码
	 */
	@Schema(description = "岗位编码")
	private String postCode;

	/**
	 * 岗位名称
	 */
	@Schema(description = "岗位名称")
	private String postName;

	/**
	 * 岗位排序
	 */
	@Schema(description = "岗位排序")
	private Integer postSort;

	/**
	 * 备注信息
	 */
	@Schema(description = "备注信息")
	private String remark;

}
