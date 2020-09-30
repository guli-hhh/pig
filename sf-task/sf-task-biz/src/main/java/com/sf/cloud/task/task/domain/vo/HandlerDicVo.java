package com.sf.cloud.task.task.domain.vo;

import com.sf.cloud.task.task.domain.po.Handler;
import com.sf.cloud.task.task.domain.po.Project;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Tolerate;

@EqualsAndHashCode(callSuper = true)
@Data
@Builder
public class HandlerDicVo extends BaseVo {

    private String label;

    private Long value;

    @Tolerate
    public HandlerDicVo() {
    }

    /**
     * @param po
     * @Description 将po属性赋值到vo
     * @Return
     * @Author tuzhaoliang
     * @Date 2020/9/10 11:11
     */
    public HandlerDicVo fromPo(Handler po) {
        HandlerDicVo handlerDicVo = super.fromPo(po);
        handlerDicVo.setLabel(po.getHandlerName());
        handlerDicVo.setValue(po.getId());
        return handlerDicVo;
    }
}
