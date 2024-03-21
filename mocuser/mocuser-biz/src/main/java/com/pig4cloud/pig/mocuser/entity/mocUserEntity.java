package com.pig4cloud.pig.mocuser.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * moc用户系统
 *
 * @author pig
 * @date 2024-03-21 18:34:40
 */
@Data
@TableName("user")
@EqualsAndHashCode(callSuper = true)
@Schema(description = "moc用户系统")
public class mocUserEntity extends Model<mocUserEntity> {


	public mocUserEntity(String name, String uuid, Long regtime, Integer lv, String pwd, String phone) {
		this.name = name;
		this.uuid = uuid;
		this.regtime = regtime;
		this.lv = lv;
		this.pwd = pwd;
		this.phone = phone;
	}

	/**
	* 数据库id
	*/
    @TableId(type = IdType.ASSIGN_ID)
    @Schema(description="数据库id")
    private Long id;

	/**
	* 用户名
	*/
    @Schema(description="用户名")
    private String name;

	/**
	* 用户id
	*/
    @Schema(description="用户id")
    private String uuid;

	/**
	* 年龄
	*/
    @Schema(description="年龄")
    private Integer age;

	/**
	* 注册时间戳
	*/
    @Schema(description="注册时间戳")
    private Long regtime;

	/**
	* 等级
	*/
    @Schema(description="等级")
    private Integer lv;

	/**
	* 密码
	*/
    @Schema(description="密码")
    private String pwd;

	/**
	* 手机号
	*/
    @Schema(description="手机号")
    private String phone;

	/**
	* 邮件
	*/
    @Schema(description="邮件")
    private String email;

	/**
	* qq
	*/
    @Schema(description="qq")
    private String qq;

	/**
	* 微信
	*/
    @Schema(description="微信")
    private String wchat;

	/**
	* 抖音
	*/
    @Schema(description="抖音")
    private String douyin;

	/**
	* 快手
	*/
    @Schema(description="快手")
    private String kuaishou;

	/**
	* 哔哩哔哩
	*/
    @Schema(description="哔哩哔哩")
    private String bilibili;
}
