export const tableOption = {
  "column": [
    {
      "prop": "id",
      "type": "input",
      "label": "主键",
      "display": false,
      "readonly": true
    },
    {
      "prop": "projectName",
      "type": "input",
      "label": "项目名称"
    },
    {
      "prop": "roleIds",
      "type": "input",
      "label": "所属角色",
      "formslot": true,
      "slot": true
    },
    {
      "prop": "createTime",
      "type": "input",
      "label": "创建时间",
      "display": false,
      "readonly": true
    },
    {
      "prop": "modifiedTime",
      "type": "input",
      "label": "更新时间",
      "display": false,
      "readonly": true
    }
  ],
  "labelPosition": "right",
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
  "align": "center",
  "index": true,
  "border": true,
  "stripe": true,
  "menuAlign": "center",
  "indexLabel": "序号",
  "searchMenuSpan": 6
}
