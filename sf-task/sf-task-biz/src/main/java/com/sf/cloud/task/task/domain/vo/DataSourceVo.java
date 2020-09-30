package com.sf.cloud.task.task.domain.vo;

import com.sf.cloud.task.task.domain.po.BasePo;
import com.sf.cloud.task.task.domain.po.DataSource;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Tolerate;

import java.time.LocalDateTime;

/**
  * @Description 前台展示对象
  * @Author tuzhaoliang
  * @Date 2020/9/9 16:40
  **/
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@ApiModel(value = "数据源表")
public class DataSourceVo extends BaseVo{
    /**
     * 主键
     */
    @ApiModelProperty(value = "主键")
    private Long id;
    /**
     * 数据源名称
     */
    @ApiModelProperty(value = "数据源名称")
    private String name;
    /**
     * 所属平台
     */
    @ApiModelProperty(value = "所属平台")
    private String platformName;
    /**
     * 数据源链接
     */
    @ApiModelProperty(value = "数据源链接")
    private String url;
    /**
     * 数据源用户名
     */
    @ApiModelProperty(value = "数据源用户名")
    private String username;
    /**
     * 数据源密码
     */
    @ApiModelProperty(value = "数据源密码")
    private String password;
    /**
     * 数据源驱动类
     */
    @ApiModelProperty(value = "数据源驱动类")
    private String driverClass;
    /**
     * 创建时间
     */
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime createTime;
    /**
     * 更新时间
     */
    @ApiModelProperty(value = "更新时间")
    private LocalDateTime modifiedTime;

    @Tolerate
    public DataSourceVo() {
    }
}
