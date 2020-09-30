import request from '@/router/axios'

export function getDic(url, requestType) {
  return request({
    url,
    method: requestType == null ? 'get' : requestType
  })
}

export function initDicData(propName, tableOption, url, requestType) {
  getDic(url, requestType)
    .then(response => {
      let dic = response.data.data
      console.log("打印" + propName + "的dic")
      console.log(dic)
      tableOption.column.forEach(item => {
        if (item.prop && item.prop == propName) {
          item.dicData = dic
        }
      })
      return dic
    }).catch(() => {
      // this.tableLoading = false
    })
}

export function initSelectOption(propName, selectOption, url, requestType) {
  getDic(url, requestType)
    .then(response => {
      selectOption = response.data.data
      console.log('打印selectOption')
      console.log(selectOption)
    }).catch(() => {
    })
}
