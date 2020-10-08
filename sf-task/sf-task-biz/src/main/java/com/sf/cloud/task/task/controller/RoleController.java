package com.sf.cloud.task.task.controller;

import cn.hutool.core.map.MapUtil;
import com.pig4cloud.pig.admin.api.entity.SysRole;
import com.pig4cloud.pig.admin.api.entity.SysUser;
import com.pig4cloud.pig.admin.api.feign.RemoteUserService;
import com.pig4cloud.pig.common.core.constant.SecurityConstants;
import com.pig4cloud.pig.common.core.util.R;
import com.sf.cloud.task.feign.feign.RemoteUpmsService;
import com.sf.cloud.task.task.domain.po.Project;
import com.sf.cloud.task.task.domain.vo.ProjectDicVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/role" )
@Api(value = "task", tags = "角色查询")
public class RoleController {

    private final RemoteUpmsService remoteUpmsService;

    /**
     * 查询用户(用于前台下拉框使用)
     * @return R
     */
    @ApiOperation(value = "项目用户角色数据字典(用于前台下拉框使用)", notes = "项目用户角色数据字典(用于前台下拉框使用)")
    @GetMapping("/dic" )
    @PreAuthorize("@pms.hasPermission('task_project_get')" )
    public R getById(@PageableDefault(value = 20, sort = { "id" }, direction = Sort.Direction.DESC)
                             Pageable pageable) {
		List<SysRole> infos = (List<SysRole>) remoteUpmsService.listRoles().getData();
        List<HashMap<String, Object>> selectOptions = infos
                .stream()
                .map(role -> {
                    HashMap<String, Object> selectOption = MapUtil.newHashMap();
                    selectOption.put("label", role.getRoleName());
                    selectOption.put("value", role.getRoleId());
                    return selectOption;
                })
                .collect(Collectors.toList());
        return R.ok(selectOptions);
    }
}
