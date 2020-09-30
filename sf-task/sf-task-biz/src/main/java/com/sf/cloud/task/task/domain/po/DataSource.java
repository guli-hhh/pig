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

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.sf.cloud.task.task.constant.Platform;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import lombok.experimental.Tolerate;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 数据源表
 *
 * @author tucent
 * @date 2020-09-09 11:18:30
 */
@EqualsAndHashCode(callSuper = true)
@Setter
@Getter
@Builder
@Entity
@Table(name = "data_source")
@EntityListeners(AuditingEntityListener.class)
@ApiModel(value = "数据源表")
public class DataSource extends BasePo {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @ApiModelProperty(value = "主键")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    /**
     * 数据源名称
     */
    @ApiModelProperty(value = "数据源名称")
    @Column
    private String name;
    /**
     * 所属平台
     */
    @ApiModelProperty(value = "所属平台")
    @Column(name = "platform")
    @Enumerated(EnumType.STRING)
    private Platform platform;
    /**
     * 数据源链接
     */
    @ApiModelProperty(value = "数据源链接")
    @Column
    private String url;
    /**
     * 数据源用户名
     */
    @ApiModelProperty(value = "数据源用户名")
    @Column
    private String username;
    /**
     * 数据源密码
     */
    @ApiModelProperty(value = "数据源密码")
    @Column
    private String password;
    /**
     * 数据源驱动类
     */
    @ApiModelProperty(value = "数据源驱动类")
    @Column(name = "driver_class")
    private String driverClass;

    @JsonIgnore
    @ManyToMany(mappedBy = "dataSources",fetch=FetchType.EAGER)
    private List<Task> tasks;
    /**
     * 创建时间
     */
    @ApiModelProperty(value = "创建时间")
    @Column(name = "create_time")
    @CreatedDate
    private LocalDateTime createTime;
    /**
     * 更新时间
     */
    @ApiModelProperty(value = "更新时间")
    @Column(name = "modified_time")
    @LastModifiedDate
    private LocalDateTime modifiedTime;

    @Tolerate
    public DataSource() {
    }
}
