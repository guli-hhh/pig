export const tableOption = {
  selection: true,
  "border": true,
  "index": true,
  "indexLabel": "序号",
  "stripe": true,
  "menuAlign": "center",
  "align": "center",
  "searchMenuSpan": 6,
  "column": [{
      "type": "input",
      "label": "主键",
      "prop": "id",
      "display": false,
      "readonly": true,
      "hide": true
    }, {
      "type": "input",
      "label": "任务名称",
      "prop": "name"
    }, {
      "label": "任务状态",
      "prop": "state",
      "dicData": [],
      "slot": true,
      "display": false
    },
    {
      "type": "switch",
      "label": "本地/远端",
      "prop": "isLocalTask",
      "display": true,
      "valueDefault": 0,
      "dicData": []
    }, {
      "type": "select",
      "label": "项目",
      "prop": "projectId",
      "dicData": []
    }, {
      "label": "数据源",
      "prop": "dataSources",
      "formslot": true,
      "slot": true
    }, {
      "type": "select",
      "label": "处理器",
      "prop": "handlerId",
      "dicData": []
    }, {
      "type": "input",
      "label": "上次执行时间",
      "prop": "previousFireTime",
      "display": false,
      "readonly": true
    }, {
      "type": "input",
      "label": "下次执行时间",
      "prop": "nextFireTime",
      "display": false,
      "readonly": true
    }, {
      "type": "input",
      "label": "cron表达式",
      "prop": "cron",
      "formslot": true
    }, {
      "type": "input",
      "label": "备注",
      "prop": "remark"
    }, {
      "type": "input",
      "label": "创建时间",
      "prop": "createTime",
      "display": false,
      "readonly": true,
      "hide": true
    }, {
      "type": "input",
      "label": "更新时间",
      "prop": "modifiedTime",
      "display": false,
      "readonly": true
    }
    // ,
    // {
    //   "label": "哈哈",
    //   "prop": "cron",
    //   // "slot": true,
    //   "formslot": true
    // }
  ]
}
