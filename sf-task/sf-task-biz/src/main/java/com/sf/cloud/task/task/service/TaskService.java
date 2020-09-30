package com.sf.cloud.task.task.service;

import com.sf.cloud.task.task.domain.po.Task;

import java.util.List;

public interface TaskService extends BaseService<Task,Long> {

    void initLocalTask();

    /**
      * @Description 开启任务
      * @Author tuzhaoliang
      * @Date 2020/9/17 15:55
      **/
    void startTask(List<Task> dbTasks);

    /**
     * @Description 停止任务
     * @Author tuzhaoliang
     * @Date 2020/9/17 15:55
     **/
    void stopTask(List<Task> dbTasks);
}
