package com.sf.cloud.task.task.job;

import cn.hutool.cron.task.Task;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class SmsTask implements Task {
    /**
     * 执行作业
     * <p>
     * 作业的具体实现需考虑异常情况，默认情况下任务异常在监听中统一监听处理，如果不加入监听，异常会被忽略<br>
     * 因此最好自行捕获异常后处理
     */
    @Override
    public void execute() {
        log.info("发送短信");
    }
}
