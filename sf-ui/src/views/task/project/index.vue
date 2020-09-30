<!--
  -    Copyright (c) 2018-2025, lengleng All rights reserved.
  -
  - Redistribution and use in source and binary forms, with or without
  - modification, are permitted provided that the following conditions are met:
  -
  - Redistributions of source code must retain the above copyright notice,
  - this list of conditions and the following disclaimer.
  - Redistributions in binary form must reproduce the above copyright
  - notice, this list of conditions and the following disclaimer in the
  - documentation and/or other materials provided with the distribution.
  - Neither the name of the pig4cloud.com developer nor the names of its
  - contributors may be used to endorse or promote products derived from
  - this software without specific prior written permission.
  - Author: lengleng (wangiegie@gmail.com)
  -->
<template>
    <div class="execution">
        <basic-container>
            <avue-crud ref="crud"
                       :page="page"
                       :data="tableData"
                       :permission="permissionList"
                       :table-loading="tableLoading"
                       :option="tableOption"
                       @on-load="getList"
                       @search-change="searchChange"
                       @refresh-change="refreshChange"
                       @size-change="sizeChange"
                       @current-change="currentChange"
                       @row-update="handleUpdate"
                       @row-save="handleSave"
                       @row-del="rowDel">

                <!-- 项目负责人编辑选项 -->
                <template slot="userIdsForm" slot-scope="scope" >
                    <el-select v-model="scope.row.userIds" multiple placeholder="请选择">
                        <el-option
                          v-for="item in userIdsDict"
                          :key="item.value"
                          :label="item.label"
                          :value="item.value">
                        </el-option>
                    </el-select>
                </template>

                <!-- 项目负责人显示选项 -->
                <template slot="userIds" slot-scope="scope" >
                    <el-tag
                      v-for="userId in scope.row.userIds"
                      :key="userId"
                      v-text="getUserName(userId)">
                    </el-tag>
                </template>
            </avue-crud>
        </basic-container>
    </div>
</template>

<script>
    import {fetchList, getObj, addObj, putObj, delObj} from '@/api/project'
    import {tableOption} from '@/const/crud/project'
    import {mapGetters} from 'vuex'
    import request from '@/router/axios'

    export default {
        name: 'project',
        data() {
            return {
                searchForm: {},
                tableData: [],
                page: {
                    total: 0, // 总页数
                    currentPage: 1, // 当前页数
                    pageSize: 20 // 每页显示多少条
                },
                tableLoading: false,
                tableOption: tableOption,
                userIdsDict: []
            }
        },
        computed: {
            ...mapGetters(['permissions']),
            permissionList() {
                return {
                    addBtn: this.vaildData(this.permissions.task_project_add, false),
                    delBtn: this.vaildData(this.permissions.task_project_del, false),
                    editBtn: this.vaildData(this.permissions.task_project_edit, false)
                };
            }
        },
        methods: {
            getList(page, params) {
                this.tableLoading = true
                fetchList(Object.assign({
                    current: page.currentPage,
                    size: page.pageSize
                }, params, this.searchForm )).then(response => {
                  console.log(response)
                    this.tableData = response.data.data.content
                    this.page.total = response.data.data.totalPages
                    this.tableLoading = false
                }).catch(() => {
                    this.tableLoading=false
                })
            },
            rowDel: function (row, index) {
                this.$confirm('是否确认删除ID为' + row.id, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(function () {
                    return delObj(row.id)
                }).then(data => {
                    this.$message.success('删除成功')
                    this.getList(this.page)
                })
            },
            handleUpdate: function (row, index, done,loading) {
                putObj(row).then(data => {
                    this.$message.success('修改成功')
                    done()
                    this.getList(this.page)
                }).catch(() => {
                    loading();
                });
            },
            handleSave: function (row, done,loading) {
                addObj(row).then(data => {
                    this.$message.success('添加成功')
                    done()
                    this.getList(this.page)
                }).catch(() => {
                    loading();
                });
            },
            sizeChange(pageSize){
                this.page.pageSize = pageSize
            },
            currentChange(current){
                this.page.currentPage = current
            },
            searchChange(form, done) {
                this.searchForm = form
                this.page.currentPage = 1
                this.getList(this.page, form)
                done()
            },
            refreshChange() {
                this.getList(this.page)
            },
            initUserDictSelectOption(){
              request({
                url: '/task/user/dic',
                method: 'get'
              }).then(response => {
                this.userIdsDict = response.data.data
              }).catch(() => {
              })
            },
            getUserName(userId){
              let username = ''
              this.userIdsDict.forEach(userSelectOption => {
                if(userId == userSelectOption.value){
                  username = userSelectOption.label
                }
              })
              return username
            }
        },
        created: function() {
          this.initUserDictSelectOption()
        }
    }
</script>
