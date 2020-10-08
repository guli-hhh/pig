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

  export default {
    name: 'wel',
    data() {
      return {
        activeNames: ['1', '2', '3', '4'],
        DATA: [],
        text: '',
        actor: '',
        count: 0,
        isText: false,
        option: {
                  data: [
                            {
                              title: '短信统计',
                              subtitle: '已发送',
                              count: 3,
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
                }
      }
    },
    computed: {
      ...mapGetters(['website'])
    },
    methods: {
      getData() {
        if (this.count < this.DATA.length - 1) {
          this.count++
        } else {
          this.count = 0
        }
        this.isText = true
        this.actor = this.DATA[this.count]
      },
      setData() {
        let num = 0
        let count = 0
        let active = false
        let timeoutstart = 5000
        let timeoutend = 1000
        let timespeed = 10
        setInterval(() => {
          if (this.isText) {
            if (count == this.actor.length) {
              active = true
            } else {
              active = false
            }
            if (active) {
              num--
              this.text = this.actor.substr(0, num)
              if (num == 0) {
                this.isText = false
                setTimeout(() => {
                  count = 0
                  this.getData()
                }, timeoutend)
              }
            } else {
              num++
              this.text = this.actor.substr(0, num)
              if (num == this.actor.length) {
                this.isText = false
                setTimeout(() => {
                  this.isText = true
                  count = this.actor.length
                }, timeoutstart)
              }
            }
          }
        }, timespeed)
      }
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
