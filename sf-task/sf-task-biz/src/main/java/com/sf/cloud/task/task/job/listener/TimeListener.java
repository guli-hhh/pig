package com.sf.cloud.task.task.job.listener;

import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.cron.CronUtil;
import cn.hutool.cron.TaskExecutor;
import cn.hutool.cron.TaskTable;
import cn.hutool.cron.listener.TaskListener;
import com.sf.cloud.task.task.domain.po.Task;
import com.sf.cloud.task.task.service.TaskService;
import com.sf.cloud.task.task.utils.TaskUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.Optional;

@Slf4j
@AllArgsConstructor
@Component
public class TimeListener implements TaskListener {

    private final TaskService taskService;

    /**
     * 定时任务启动时触发
     *
     * @param executor {@link TaskExecutor}
     */
    @Override
    public void onStart(TaskExecutor executor) {
        Optional<String> tId = TaskUtil.findTaskIdByTask(executor.getTask());
        tId.ifPresent(taskId -> {
            Task dbTask = taskService.findById(Long.valueOf(taskId));
            dbTask.setPreviousFireTime(LocalDateTime.now());
            log.info("任务：{} 开始执行, 时间: {}", dbTask.getName(), LocalDateTimeUtil.now());
            taskService.save(dbTask);
        });
    }

    /**
     * 任务成功结束时触发
     *
     * @param executor {@link TaskExecutor}
     */
    @Override
    public void onSucceeded(TaskExecutor executor) {

    }

    /**
     * 任务启动失败时触发
     *
     * @param executor  {@link TaskExecutor}
     * @param exception 异常
     */
    @Override
    public void onFailed(TaskExecutor executor, Throwable exception) {

    }
}
