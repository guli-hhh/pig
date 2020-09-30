export const tableOption = {
  "column": [
    {
      "type": "input",
      "label": "主键",
      "prop": "id",
      "display": false
    },
    {
      "type": "input",
      "label": "处理器名称",
      "prop": "handlerName"
    },
    {
      "type": "input",
      "label": "处理器执行类",
      "prop": "handlerClass"
    },
    {
      "type": "input",
      "label": "创建时间",
      "prop": "createTime",
      "readonly": true,
      "display": false
    },
    {
      "type": "input",
      "label": "更新时间",
      "prop": "modifiedTime",
      "readonly": true,
      "showWordLimit": false,
      "display": false
    }
  ],
  "labelPosition": "left",
  "labelSuffix": "：",
  "labelWidth": 120,
  "gutter": 0,
  "menuBtn": true,
  "submitBtn": true,
  "submitSize": "medium",
  "submitText": "提交",
  "emptyBtn": true,
  "emptySize": "medium",
  "emptyText": "清空",
  "menuPosition": "center",
  "border": true,
  "index": true,
  "indexLabel": "序号",
  "stripe": true,
  "menuAlign": "center",
  "align": "center",
  "searchMenuSpan": 6
}
