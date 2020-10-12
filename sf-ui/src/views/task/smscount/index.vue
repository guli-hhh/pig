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
          剩余短信
            <template>
              <el-input-number v-model="remainCount" :step="100" :disabled="!this.permissionList.editBtn"></el-input-number>条
            </template>
            <el-button type="primary" :loading="saveLoading" :disabled="!this.permissionList.editBtn" @click="handleUpdate(remainCount)">保存</el-button>
        </basic-container>
    </div>
</template>

<script>
    import {getRemain, setRemain} from '@/api/smscount'
    import {mapGetters} from 'vuex'

    export default {
        name: 'smscount',
        data() {
            return {
                remainCount: 0,
                saveLoading: false
            }
        },
        computed: {
            ...mapGetters(['permissions']),
            permissionList() {
                return {
                    editBtn: this.vaildData(this.permissions.task_smscount_edit, false)
                };
            }
        },
        methods: {
            getList() {
                getRemain().then(response => {
                    this.remainCount = response.data.data
                }).catch(() => {
                })
            },
            handleUpdate(remainCount) {
                this.saveLoading = true
                setRemain(remainCount).then(data => {
                    this.$message.success('修改成功')
                    done()
                    this.getList()
                    this.saveLoading = false
                }).catch(() => {
                    this.saveLoading = false
                });
            },
            refreshChange() {
                this.getList()
            }
        },
        created() {
          this.getList()
          console.log(this.permissionList.editBtn)
        }
    }
</script>
