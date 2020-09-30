export const tableOption = {
  "border": true,
  "index": true,
  "indexLabel": "序号",
  "stripe": true,
  "menuAlign": "center",
  "align": "center",
  "searchMenuSpan": 6,
  "column": [
	  {
      "type": "input",
      "label": "主键",
      "prop": "id"
    },{
      "type": "input",
      "label": "项目",
      "prop": "projectName"
    }, {
      "type": "select",
      "label": "平台",
      "prop": "platform",
      "dicData": []
    }, {
      "type": "input",
      "label": "处理器",
      "prop": "handlerName"
    },	  {
      "type": "input",
      "label": "报警内容",
      "prop": "message",
      "overHidden": true
    },	  {
      "label": "任务状态",
      "prop": "state",
      "dicData": [],
      "slot": true,
      "display": false
    }
    // ,	  {
    //   "type": "input",
    //   "label": "消息等级(预留)",
    //   "prop": "level"
    // }
    ,	  {
      "type": "input",
      "label": "发送时间",
      "prop": "sendTime",
      "display": false
    },	  {
      "type": "input",
      "label": "创建时间",
      "prop": "createTime",
      "display": false
    },	  {
      "type": "input",
      "label": "更新时间",
      "prop": "modifiedTime",
      "display": false
    }  ]
}
