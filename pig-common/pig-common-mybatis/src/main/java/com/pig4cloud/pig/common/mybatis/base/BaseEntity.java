package com.pig4cloud.pig.common.mybatis.base;

import com.mybatisflex.annotation.Column;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 抽象实体
 *
 * @author lengleng
 * @updateAuthor Oliver
 * @date 2021/8/9
 * @updateTime 2023/8/16
 */
@Getter
@Setter
public class BaseEntity implements Serializable {

	/**
	 * 创建者
	 */
	@Schema(description = "创建人")
	private String createBy;

	/**
	 * 创建时间
	 */
	@Schema(description = "创建时间")
	@Column(onInsertValue = "now()")
	private LocalDateTime createTime;

	/**
	 * 更新者
	 */
	@Schema(description = "更新人")
	private String updateBy;

	/**
	 * 更新时间
	 */
	@Schema(description = "更新时间")
	@Column(onInsertValue = "now()")
	private LocalDateTime updateTime;

	/**
	 * 是否删除 1：已删除 0：正常
	 */
	@Column(isLogicDelete = true,onInsertValue = "0")
	private String delFlag;
}
