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

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Tolerate;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 * 处理器表
 *
 * @author tucent
 * @date 2020-09-08 15:45:58
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@Entity
@Table(name = "handler")
@EntityListeners(AuditingEntityListener.class)
@ApiModel(value = "处理器表")
public class Handler extends BasePo {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @ApiModelProperty(value = "主键")
    private Long id;
    /**
     * 处理器名称
     */
    @Column(name = "handler_name")
    @ApiModelProperty(value = "处理器名称")
    private String handlerName;
    /**
     * 处理器执行类
     */
    @Column(name = "handler_class")
    @ApiModelProperty(value = "处理器执行类")
    private String handlerClass;
    /**
     * 创建时间
     */
    @Column(name = "create_time")
    @ApiModelProperty(value = "创建时间")
    @CreatedDate
    private LocalDateTime createTime;
    /**
     * 更新时间
     */
    @Column(name = "modified_time")
    @ApiModelProperty(value = "更新时间")
    @LastModifiedDate
    private LocalDateTime modifiedTime;

    @Tolerate
    public Handler() {}
}
