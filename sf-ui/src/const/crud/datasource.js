export const tableOption = {
  "column": [
    {
      "type": "input",
      "label": "主键",
      "prop": "id",
      "addDisplay": false,
      "editDisplay": false
    },
    {
      "type": "input",
      "label": "数据源名称",
      "prop": "name"
    },
    {
      "type": "select",
      "label": "所属平台",
      "prop": "platform",
      "dicData": []
    },
    {
      "type": "input",
      "label": "数据源链接",
      "prop": "url",
      "overHidden": true
    },
    {
      "type": "input",
      "label": "数据源用户名",
      "prop": "username"
    },
    {
      "type": "input",
      "label": "数据源密码",
      "prop": "password"
    },
    {
      "type": "input",
      "label": "数据源驱动类",
      "prop": "driverClass"
    },
    {
      "type": "input",
      "label": "创建时间",
      "prop": "createTime",
      "addDisplay": false,
      "editDisplay": false
    },
    {
      "type": "input",
      "label": "更新时间",
      "prop": "modifiedTime",
      "addDisplay": false,
      "editDisplay": false
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
