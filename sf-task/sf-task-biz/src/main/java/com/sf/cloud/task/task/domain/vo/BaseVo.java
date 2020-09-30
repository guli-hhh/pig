package com.sf.cloud.task.task.domain.vo;

import com.sf.cloud.task.task.domain.po.BasePo;
import org.springframework.beans.BeanUtils;

public class BaseVo {

    /**
      * @Description 将po属性赋值到vo
      * @Return
      * @Author tuzhaoliang
      * @Date 2020/9/10 11:11
      **/
    public <T extends BaseVo> T fromPo(BasePo po) {
        BeanUtils.copyProperties(po, this);
        return (T) this;
    }
}
