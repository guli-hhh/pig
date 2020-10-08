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
import com.sf.cloud.task.task.config.db.ListToIntegerConverter;
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
import java.util.List;

/**
 * 项目分组表
 *
 * @author tucent
 * @date 2020-09-08 17:23:57
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@Entity
@Table(name = "project")
@EntityListeners(AuditingEntityListener.class)
@ApiModel(value = "项目分组表")
public class Project extends BasePo {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @ApiModelProperty(value = "主键")
    private Long id;
    /**
     * 项目名称
     */
    @ApiModelProperty(value = "项目名称")
    @Column(name = "project_name")
    private String projectName;

	@ApiModelProperty(value = "所属用户角色")
    @Convert(converter = ListToIntegerConverter.class)
    @Column(name = "role_id")
    private List<Integer> roleIds;
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
    @LastModifiedDate
    @Column(name = "modified_time")
    private LocalDateTime modifiedTime;

    @Tolerate
    public Project() {}
}
