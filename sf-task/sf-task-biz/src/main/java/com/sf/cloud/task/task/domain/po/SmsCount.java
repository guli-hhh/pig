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

package com.sf.cloud.task.task.domain.po;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Tolerate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

/**
 * 短信配置表
 *
 * @author tucent
 * @date 2020-10-10 14:54:59
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@Entity
@Table(name = "sms_count")
@EntityListeners(AuditingEntityListener.class)
@ApiModel(value = "短信配置表")
public class SmsCount extends BasePo {
	private static final long serialVersionUID = 1L;

	/**
	 * 主键
	 */
	@ApiModelProperty(value = "主键")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/**
	 * 剩余短信数量
	 */
	@ApiModelProperty(value = "剩余短信数量")
	@Column
	private Long remain;
	/**
	 * 已发送短信数量
	 */
	@ApiModelProperty(value = "已发送短信数量")
	@Column(name = "has_send")
	private Long hasSend;

	@Tolerate
	public SmsCount() {}
}
