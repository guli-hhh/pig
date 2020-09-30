package com.sf.cloud.task.task.utils;

import cn.hutool.cron.CronUtil;
import cn.hutool.cron.TaskTable;
import cn.hutool.cron.task.Task;

import java.util.Optional;

public class TaskUtil {

    public static Optional<String> findTaskIdByTask(Task task) {
        TaskTable taskTable = CronUtil.getScheduler().getTaskTable();
        return taskTable.getIds().stream()
                .filter(taskId -> taskTable.getTask(taskId) == task)
                .findFirst();
    }
}
