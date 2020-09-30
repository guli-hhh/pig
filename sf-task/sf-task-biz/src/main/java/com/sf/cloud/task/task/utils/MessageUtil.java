package com.sf.cloud.task.task.utils;

import cn.hutool.core.util.StrUtil;

import java.util.Map;

public class MessageUtil {

    private final String MESSAGE_TEMPLATE = "(${projectName}最近 ${recentDays} 天 ${deviceType} 离线)位置: ${address}, ${gatherAddress}, 离线数量: ${offLineNum}, 总数量: ${totalNum}。";

    public static String createWaterMeterMsg(Map<String,String> valuesMap) {
//        StringSubstitutor sub = new StringSubstitutor(valuesMap);
//        StrUtil.
        return null;
    }
}
