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
              <!-- 任务状态列 -->
              <template slot="state" slot-scope="scope" >
                  <el-tag v-if="scope.row.state == 'HAS_SEND'" type="success" effect="dark" v-text="messageStateText(scope)"></el-tag>
                  <el-tag v-if="scope.row.state == 'NOT_SEND'" type="danger" effect="dark" v-text="messageStateText(scope)"></el-tag>
              </template>
            </avue-crud>

        </basic-container>
    </div>
</template>

<script>
    import {fetchList, getObj, addObj, putObj, delObj} from '@/api/message'
    import {tableOption} from '@/const/crud/message'
    import {mapGetters} from 'vuex'
    import {initDicData} from '@/util/dictionaryUtil.js'

    export default {
        name: 'message',
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
                tableOption: tableOption
            }
        },
        computed: {
            ...mapGetters(['permissions']),
            permissionList() {
                return {
                    addBtn: this.vaildData(this.permissions.task_message_add, false),
                    delBtn: this.vaildData(this.permissions.task_message_del, false),
                    editBtn: this.vaildData(this.permissions.task_message_edit, false)
                };
            }
        },
        methods: {
            getList(page, params) {
              console.log('------')
                this.tableLoading = true
                fetchList(Object.assign({
                  current: page.currentPage,
                  size: page.pageSize
                }, params, this.searchForm)).then(response => {
                  this.tableData = response.data.data.content
                  this.page.total = response.data.data.totalPages
                  this.tableLoading = false
                }).catch(() => {
                  this.tableLoading = false
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
                if(!row.state || row.state == ''){
                  row.state = 'NOT_SEND'
                }
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
            messageStateText(scope){
              let messageStateText = ''
              let dicData = []
              tableOption.column.forEach(item => {
                if (item.prop && item.prop == 'state') {
                  dicData = item.dicData
                }
              })
              dicData.forEach(item => {
                if(item.value == scope.row.state){
                  messageStateText = item.label
                }
              })
              return messageStateText
            }
        },
        created: function() {
            initDicData("platform", this.tableOption , '/admin/dict/type/platform_type')
            initDicData("state", this.tableOption , '/admin/dict/type/message_state')
        }
    }
</script>
