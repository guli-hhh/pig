/*
 *    Copyright (c) 2018-2025, lengleng All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * Neither the name of the pig4cloud.com developer nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 * Author: lengleng (wangiegie@gmail.com)
 */

import request from '@/router/axios'

export function getRemain() {
  return request({
    url: '/task/smscount/remain',
    method: 'get'
  })
}

export function setRemain(remainCount) {
  return request({
    url: '/task/smscount/remain/' + remainCount,
    method: 'put'
  })
}

export function getHasSend() {
  return request({
    url: '/task/smscount/has_send',
    method: 'get'
  })
}
