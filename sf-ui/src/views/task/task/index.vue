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
      <avue-crud ref="crud" :page="page" :data="tableData" :permission="permissionList" :table-loading="tableLoading"
        :option="tableOption" @on-load="getList" @search-change="searchChange" @refresh-change="refreshChange"
        @size-change="sizeChange" @current-change="currentChange" @row-update="handleUpdate" @row-save="handleSave"
        @row-del="rowDel"
        @selection-change="selectionChange">

        <!-- 表单页面cron设置 -->
        <template slot="cronForm" slot-scope="scope">
          <el-popover
              placement="bottom"
              title="标题"
              trigger="click"
              v-model="visible">
              <cron @change="changeCron" @close="visible=false" i18n="cn"></cron>
              <el-input slot="reference" @focus="clickCron(scope)"  v-model="scope.row.cron" placeholder="请输入定时策略"></el-input>
            </el-popover>
        </template>

        <!-- 任务状态列 -->
        <template slot="state" slot-scope="scope" >
            <el-tag v-if="scope.row.state == 'START'" type="success" effect="dark" v-text="taskStateText(scope)"></el-tag>
            <el-tag v-if="scope.row.state == 'STOPPED'" type="danger" effect="dark" v-text="taskStateText(scope)"></el-tag>
        </template>

        <!-- 自定义多选勾选 -->
        <template slot="menuLeft">
            <el-button type="success" icon="el-icon-video-play" v-bind:disabled="selected.length == 0" @click="startTask">开启任务</el-button>
            <el-button type="danger" icon="el-icon-video-pause" v-bind:disabled="selected.length == 0" @click="stopTask">停止任务</el-button>
        </template>

        <!-- 平台列表单编辑选项 -->
        <template slot="dataSourcesForm" slot-scope="scope" >
            <el-select v-model="scope.row.dataSourcesIds" multiple placeholder="请选择">
                <el-option
                  v-for="item in dataSourcesDict"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
            </el-select>
        </template>

        <!-- 平台列显示选项 -->
        <template slot="dataSources" slot-scope="scope" >
            <el-tag
              v-for="dataSource in scope.row.dataSources"
              :key="dataSource.id">
              {{dataSource.name}}
            </el-tag>
        </template>
      </avue-crud>
    </basic-container>
  </div>
</template>

<script>
  import {
    fetchList, getObj, addObj, putObj, delObj, startTask, stopTask } from '@/api/task'
  import { tableOption } from '@/const/crud/task'
  import {  mapGetters } from 'vuex'
  import { cron } from 'vue-cron'
  import {initDicData, initSelectOption} from '@/util/dictionaryUtil.js'
  import request from '@/router/axios'

  export default {
    name: 'task',
    components: {
      'cron': cron
    },
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
        visible: false,
        currentScope: null,
        selected: [],
        dataSourcesDict: []
      }
    },
    computed: {
      ...mapGetters(['permissions']),
      permissionList() {
        return {
          addBtn: this.vaildData(this.permissions.task_task_add, false),
          delBtn: this.vaildData(this.permissions.task_task_del, false),
          editBtn: this.vaildData(this.permissions.task_task_edit, false)
        };
      }
    },
    methods: {
      getList(page, params) {
        this.tableLoading = true
        fetchList(Object.assign({
          current: page.currentPage,
          size: page.pageSize
        }, params, this.searchForm)).then(response => {

          this.tableData = response.data.data.content

          this.tableData.forEach(item => {
            if(item.project.id){
              item.projectId = item.project.id
            }

            if(item.handler.id){
              item.handlerId = item.handler.id
            }

            if(item.hasOwnProperty('isLocalTask')){
              item.isLocalTask = item.isLocalTask.toString()
            }

            let tempDataSourcesIds = new Array()
            item.dataSources.forEach((dataSource) => {
              tempDataSourcesIds.push(dataSource.id)
            })
            item.dataSourcesIds = tempDataSourcesIds

          })

          this.page.total = response.data.data.totalPages
          this.tableLoading = false

          console.log(this.tableData)
        }).catch(() => {
          this.tableLoading = false
        })
      },
      rowDel: function(row, index) {
        this.$confirm('是否确认删除任务名称为 ' + row.name, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function() {
          console.log('删除')
          return delObj(row.id)
        }).then(data => {
          this.$message.success('删除成功')
          this.getList(this.page)
        })
      },
      handleUpdate: function(row, index, done, loading) {
        // 设置dataSources
        row.dataSources = new Array()
        row.dataSourcesIds.forEach((id) => {
          row.dataSources.push({'id': id})
        })
        putObj(row).then(data => {
          this.$message.success('修改成功')
          done()
          this.getList(this.page)
        }).catch(() => {
          loading();
        });
      },
      handleSave: function(row, done, loading) {
        addObj(row).then(data => {
          this.$message.success('添加成功')
          done()
          this.getList(this.page)
        }).catch(() => {
          loading();
        });
      },
      sizeChange(pageSize) {
        this.page.pageSize = pageSize
      },
      currentChange(current) {
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
      changeCron(val) {
        console.log(val)
        this.currentScope.row.cron = val

      },
      clickCron(scope){
        // this.cronPopover = true
        console.log("打印scope")
        console.log(scope)
        this.currentScope = scope
      },
      selectionChange(list){
        this.selected = list
      },
      taskStateText(scope){
        let taskStateText = ''
        let dicData = []
        tableOption.column.forEach(item => {
          if (item.prop && item.prop == 'state') {
            dicData = item.dicData
          }
        })
        dicData.forEach(item => {
          if(item.value == scope.row.state){
            taskStateText = item.label
          }
        })
        return taskStateText
      },
      startTask(){
        startTask(this.selected)
        .then(data => {
          this.$message({
                    message: '提交成功',
                    type: 'success'
                  });
          this.getList(this.page)
        }).catch(() => {
          loading();
        });

      },
      stopTask(){
        stopTask(this.selected)
        .then(data => {
          this.$message({
                    message: '提交成功',
                    type: 'success'
                  });
          this.getList(this.page)
        }).catch(() => {
          loading();
        });
      },
      initDataSourcesOption(){
        request({
          url: '/task/datasource/dic',
          method: 'get'
        }).then(response => {
          this.dataSourcesDict = response.data.data
        }).catch(() => {
        })
      }

    },
    created: function() {
        initDicData("projectId", this.tableOption , '/task/project/dic')
        this.initDataSourcesOption()

        initDicData("handlerId", this.tableOption , '/task/handler/dic')
        initDicData("isLocalTask", this.tableOption , '/task/task/type/local_task')
        initDicData("state", this.tableOption , '/admin/dict/type/task_state')
    }
  }
</script>
