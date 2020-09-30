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

import cn.hutool.core.util.ReUtil;
import com.sf.cloud.task.task.constant.MessageState;
import com.sf.cloud.task.task.constant.Platform;
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
 * tuzhaoliang
 *
 * @author tucent
 * @date 2020-09-18 08:31:22
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@Entity
@Table(name = "message")
@EntityListeners(AuditingEntityListener.class)
@ApiModel(value = "消息表")
public class Message extends BasePo {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @ApiModelProperty(value = "主键")
    private Integer id;
    /**
     * 项目
     */
    @ApiModelProperty(value = "项目")
    @Column(name = "project_name")
    private String projectName;
    /**
     * 平台
     */
    @ApiModelProperty(value = "平台")
    @Column(name = "platform")
    @Enumerated(EnumType.STRING)
    private Platform platform;
    /**
     * 处理器
     */
    @ApiModelProperty(value = "处理器")
    @Column(name = "handler_name")
    private String handlerName;
    /**
     * 报警内容
     */
    @ApiModelProperty(value = "报警内容")
    @Column
    private String message;
    /**
     * 任务状态
     */
    @ApiModelProperty(value = "任务状态")
    @Column
    @Enumerated(EnumType.STRING)
    private MessageState state;
    /**
     * 消息等级(预留)
     */
    @ApiModelProperty(value = "消息等级(预留)")
    @Column
    private Integer level;
    /**
     * 发送时间
     */
    @ApiModelProperty(value = "发送时间")
    @Column(name = "send_time")
    private LocalDateTime sendTime;
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
    public Message() {
    }

    /**
      * @Description 消息发生位置
      * @Author tuzhaoliang
      * @Date 2020/9/27 15:15
      **/
    public String getPlace() {
        if (this.getMessage() == null) {
            return null;
        }
//        String content = "(公司平台最近电表离线)位置: 盛帆工业园.dfdfd.1号楼集中器, 4201466500, 离线数量: 81, 总数量: 81。";
        List<String> places = ReUtil.findAll("(\\(.+\\))(.+?:\\s{1})(.*?\\..*?\\..*?),.+", this.getMessage(), 3);
        if (places == null || places.isEmpty()) {
            return null;
        }
        return places.get(0);
    }
}
