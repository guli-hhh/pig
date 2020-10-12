<template>
  <div>
    <basic-container>
      <div class="banner-text">
        <span>
          <img src="https://img.shields.io/badge/Element-2.13.2-green.svg" alt="Build Status">
          <img src="https://img.shields.io/badge/Spring%20Boot-2.3.2.RELEASE-yellowgreen.svg" alt="Downloads">
          <img src="https://img.shields.io/badge/Spring%20Cloud-Hoxton.SR6-blue.svg" alt="Coverage Status">
        </span>
        <br/>
        <span>
          <el-collapse v-model="activeNames">
            <el-collapse-item name="1">
              <avue-data-tabs :option="option"></avue-data-tabs>
            </el-collapse-item>
            <el-collapse-item name="2">
              <div>统计界面待开发</div>
              <div>统计界面待开发</div>
            </el-collapse-item>
            <el-collapse-item name="3">
              <div>统计界面待开发</div>
              <div>统计界面待开发</div>
            </el-collapse-item>
            <el-collapse-item name="4">
              <div>统计界面待开发</div>
              <div>统计界面待开发</div>
              <div>详细介绍</div>
            </el-collapse-item>
          </el-collapse>
        </span>
      </div>

    </basic-container>
  </div>
</template>

<script>
  import {mapGetters} from 'vuex';
  import {getRemain, getHasSend} from '@/api/smscount'

  export default {
    name: 'wel',
    data() {
      return {
        activeNames: ['1', '2', '3', '4'],
        DATA: [],
        actor: '',
        count: 0,
        isText: false,
        option: {
                  data: [
                            {
                              title: '短信统计',
                              subtitle: '已发送',
                              count: 10,
                              allcount: 32000,
                              text: '短信总数',
                              color: 'rgb(27, 201, 142)',
                              key: '已发送'
                            }
                            // ,
                            // {
                            //   title: '附件统计',
                            //   subtitle: '实时',
                            //   count: 3112,
                            //   allcount: 10222,
                            //   text: '当前上传的附件数',
                            //   color: 'rgb(230, 71, 88)',
                            //   key: '附'
                            // },
                            // {
                            //   title: '文章统计',
                            //   subtitle: '实时',
                            //   count: 908,
                            //   allcount: 10222,
                            //   text: '评论次数',
                            //   color: 'rgb(178, 159, 255)',
                            //   key: '评'
                            // }
                          ]
                },
         remainCount: -1,
         hasSend: -1
      }
    },
    computed: {
      ...mapGetters(['website'])
    },
    methods: {
      getSmsRemain(){
        getRemain().then(response => {
            this.remainCount = response.data.data
        }).catch(() => {
        })
      },
      getHasSend(){
        getHasSend().then(response => {
            this.hasSend = response.data.data
        }).catch(() => {
        })
      }
    },
    watch: {
      remainCount(val, oldVal){
        this.option.data[0].allcount = val
      },
      hasSend(val, oldVal){
        console.log('hasSend')
        console.log(val)
        this.option.data[0].count = val
      }
    },
    created() {
      this.getSmsRemain()
      this.getHasSend()
    }
  }
</script>

<style scoped="scoped" lang="scss">
  .wel-contailer {
    position: relative;
  }

  .banner-text {
    position: relative;
    padding: 0 20px;
    font-size: 20px;
    text-align: center;
    color: #333;
  }

  .banner-img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0.8;
    display: none;
  }

  .actor {
    height: 250px;
    overflow: hidden;
    font-size: 18px;
    color: #333;
  }

  .actor:after {
    content: '';
    width: 3px;
    height: 25px;
    vertical-align: -5px;
    margin-left: 5px;
    background-color: #333;
    display: inline-block;
    animation: blink 0.4s infinite alternate;
  }

  .typeing:after {
    animation: none;
  }

  @keyframes blink {
    to {
      opacity: 0;
    }
  }
</style>
