package com.sf.cloud.task.task.domain.vo;

import com.sf.cloud.task.task.domain.po.Project;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Tolerate;

@EqualsAndHashCode(callSuper = true)
@Data
@Builder
public class ProjectDicVo extends BaseVo {

    private String label;

    private Long value;

    @Tolerate
    public ProjectDicVo() {
    }

    /**
     * @param po
     * @Description 将po属性赋值到vo
     * @Return
     * @Author tuzhaoliang
     * @Date 2020/9/10 11:11
     */
    public ProjectDicVo fromPo(Project po) {
        ProjectDicVo projectDicVo = super.fromPo(po);
        projectDicVo.setLabel(po.getProjectName());
        projectDicVo.setValue(po.getId());
        return projectDicVo;
    }
}
