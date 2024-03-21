package com.pig4cloud.pig.mocuser.controller;

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.pig4cloud.pig.common.core.util.R;
import com.pig4cloud.pig.common.log.annotation.SysLog;
import com.pig4cloud.pig.mocuser.entity.mocUserEntity;
import com.pig4cloud.pig.mocuser.service.mocUserService;

import org.springframework.security.access.prepost.PreAuthorize;
import com.pig4cloud.plugin.excel.annotation.ResponseExcel;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springdoc.api.annotations.ParameterObject;
import org.springframework.http.HttpHeaders;
import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;


/**
 * moc用户系统
 *
 * @author pig
 * @date 2024-03-21 18:34:40
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/mocuser" )
@Tag(description = "mocuser" , name = "moc用户系统管理" )
@SecurityRequirement(name = HttpHeaders.AUTHORIZATION)
public class mocUserController {

    private final  mocUserService mocUserService;

    /**
     * 分页查询
     * @param page 分页对象
     * @param mocUser moc用户系统
     * @return
     */
    @Operation(summary = "分页查询" , description = "分页查询" )
    @GetMapping("/page" )
    @PreAuthorize("@pms.hasPermission('mocuser_mocuser_view')" )
    public R getmocUserPage(@ParameterObject Page page, @ParameterObject mocUserEntity mocUser) {
        LambdaQueryWrapper<mocUserEntity> wrapper = Wrappers.lambdaQuery();
        return R.ok(mocUserService.page(page, wrapper));
    }


    /**
     * 通过id查询moc用户系统
     * @param id id
     * @return R
     */
    @Operation(summary = "通过id查询" , description = "通过id查询" )
    @GetMapping("/{id}" )
    @PreAuthorize("@pms.hasPermission('mocuser_mocuser_view')" )
    public R getById(@PathVariable("id" ) Long id) {
        return R.ok(mocUserService.getById(id));
    }

    /**
     * 新增moc用户系统
     * @param mocUser moc用户系统
     * @return R
     */
    @Operation(summary = "新增moc用户系统" , description = "新增moc用户系统" )
    @SysLog("新增moc用户系统" )
    @PostMapping
    @PreAuthorize("@pms.hasPermission('mocuser_mocuser_add')" )
    public R save(@RequestBody mocUserEntity mocUser) {
        return R.ok(mocUserService.save(mocUser));
    }

    /**
     * 修改moc用户系统
     * @param mocUser moc用户系统
     * @return R
     */
    @Operation(summary = "修改moc用户系统" , description = "修改moc用户系统" )
    @SysLog("修改moc用户系统" )
    @PutMapping
    @PreAuthorize("@pms.hasPermission('mocuser_mocuser_edit')" )
    public R updateById(@RequestBody mocUserEntity mocUser) {
        return R.ok(mocUserService.updateById(mocUser));
    }

    /**
     * 通过id删除moc用户系统
     * @param ids id列表
     * @return R
     */
    @Operation(summary = "通过id删除moc用户系统" , description = "通过id删除moc用户系统" )
    @SysLog("通过id删除moc用户系统" )
    @DeleteMapping
    @PreAuthorize("@pms.hasPermission('mocuser_mocuser_del')" )
    public R removeById(@RequestBody Long[] ids) {
        return R.ok(mocUserService.removeBatchByIds(CollUtil.toList(ids)));
    }


    /**
     * 导出excel 表格
     * @param mocUser 查询条件
   	 * @param ids 导出指定ID
     * @return excel 文件流
     */
    @ResponseExcel
    @GetMapping("/export")
    @PreAuthorize("@pms.hasPermission('mocuser_mocuser_export')" )
    public List<mocUserEntity> export(mocUserEntity mocUser,Long[] ids) {
        return mocUserService.list(Wrappers.lambdaQuery(mocUser).in(ArrayUtil.isNotEmpty(ids), mocUserEntity::getId, ids));
    }
}
