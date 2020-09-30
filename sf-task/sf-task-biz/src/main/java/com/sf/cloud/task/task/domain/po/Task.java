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

import com.sf.cloud.task.task.constant.Platform;
import com.sf.cloud.task.task.constant.TaskState;
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
 * 任务表
 *
 * @author tucent
 * @date 2020-09-11 10:27:55
 */
@EqualsAndHashCode(callSuper = true)
@Setter
@Getter
@Builder
@Entity
@Table(name = "task")
@EntityListeners(AuditingEntityListener.class)
@ApiModel(value = "任务表")
public class Task extends BasePo {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @ApiModelProperty(value = "主键")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    /**
     * 任务名称
     */
    @ApiModelProperty(value = "任务名称")
    @Column
    private String name;

    /**
     * 任务状态（查询数据字典task_state）
     */
    @ApiModelProperty(value = "任务状态（具体含义查询数据字典task_state）")
    @Column
    @Enumerated(EnumType.STRING)
    private TaskState state;

    /**
     * 本地/远端任务
     */
    @ApiModelProperty(value = "本地/远端任务")
    @Column(name = "local_task")
    private Boolean isLocalTask;
    /**
     * 项目
     */
    @ApiModelProperty(value = "项目")
    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;
    /**
     * 平台
     */
    @ApiModelProperty(value = "平台")
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "task_data_source",joinColumns = @JoinColumn(name = "task_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "data_source_id", referencedColumnName = "id"))
    private List<DataSource> dataSources;
    /**
     * 处理器
     */
    @ApiModelProperty(value = "处理器")
    @ManyToOne
    @JoinColumn(name = "handler_id")
    private Handler handler;
    /**
     * 上次执行时间
     */
    @ApiModelProperty(value = "上次执行时间")
    @Column(name = "previous_fire_time")
    private LocalDateTime previousFireTime;
    /**
     * 下次执行时间
     */
    @ApiModelProperty(value = "下次执行时间")
    @Column(name = "next_fire_time")
    private LocalDateTime nextFireTime;
    /**
     * cron表达式
     */
    @ApiModelProperty(value = "cron表达式")
    @Column
    private String cron;
    /**
     * 备注
     */
    @ApiModelProperty(value = "备注")
    @Column
    private String remark;
    /**
     * 创建时间
     */
    @ApiModelProperty(value = "创建时间")
    @CreatedDate
    @Column(name = "create_time")
    private LocalDateTime createTime;
    /**
     * 更新时间
     */
    @ApiModelProperty(value = "更新时间")
    @LastModifiedDate
    @Column(name = "modified_time")
    private LocalDateTime modifiedTime;

    @Tolerate
    public Task() {}

}
