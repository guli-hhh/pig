package com.sf.cloud.task.task.service.impl;

import cn.hutool.core.date.DateField;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.cron.CronUtil;
import cn.hutool.cron.pattern.CronPattern;
import cn.hutool.cron.pattern.CronPatternUtil;
import com.sf.cloud.task.task.constant.TaskState;
import com.sf.cloud.task.task.dao.BaseRepository;
import com.sf.cloud.task.task.dao.TaskRepository;
import com.sf.cloud.task.task.domain.po.Task;
import com.sf.cloud.task.task.service.TaskService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

/**
  * @Author tuzhaoliang
  * @Date 2020/9/11 11:03
  **/
@Slf4j
@RequiredArgsConstructor
@Service
public class TaskServiceImpl implements TaskService, ApplicationContextAware {

    private final TaskRepository taskRepository;

    private ApplicationContext applicationContext;

    @Override
    public BaseRepository<Task, Long> getRepository() {
        return taskRepository;
    }

    /**
      * @Description 保存任务：1.向数据库保存任务，2.本地任务，向CronUtil更新任务现在状态
      * @Author tuzhaoliang
      * @Date 2020/9/17 15:11
      **/
    @Override
    public Task save(Task task) {

        if (null == task.getState()) {
            task.setState(TaskState.STOPPED);
        }

        // 1.向数据库保存任务
        initTaskNextFireTime(task, null);
        Task dbTask = taskRepository.save(task);

        if (!dbTask.getIsLocalTask()) {
            // 远端任务，保存状态后可直接返回
            return dbTask;
        }

        // 2.本地任务，向CronUtil更新任务现在状态
        cn.hutool.cron.task.Task instanceTask = CronUtil.getScheduler().getTask(dbTask.getId().toString());
        boolean isInstanceTaskExist = (instanceTask != null);

        if (isInstanceTaskExist && dbTask.getState() == TaskState.START) {
            // 任务存在，且数据库为启动状态
            this.updateInstanceTask(dbTask);
            return dbTask;
        }

        if (isInstanceTaskExist && dbTask.getState() == TaskState.STOPPED) {
            // 任务存在，且数据库为停止状态状态
            this.deleteInstanceTask(dbTask);
            return dbTask;
        }

        if (!isInstanceTaskExist && dbTask.getState() == TaskState.START) {
            // 任务不存在，且数据库为启动状态
            this.addInstanceTask(dbTask);
            return dbTask;
        }

        // 任务不存在，且数据库为停止状态
        return dbTask;
    }

    @Override
    public void initLocalTask() {
        Task task = Task.builder()
                .isLocalTask(true)
                .state(TaskState.START)
                .build();
        List<Task> localTasks = taskRepository.findAll(Example.of(task));
        localTasks.forEach(this::save);
    }

    /**
     * @param dbTasks
     * @Description 开启任务
     * @Author tuzhaoliang
     * @Date 2020/9/17 15:55
     */
    @Override
    public void startTask(List<Task> dbTasks) {
        dbTasks.stream().peek(task -> task.setState(TaskState.START))
                .forEach(this::save);
    }

    @Override
    public void stopTask(List<Task> dbTasks) {
        dbTasks.stream().peek(task -> task.setState(TaskState.STOPPED))
                .forEach(this::save);
    }

    /**
      * @Description 添加任务：.启动任务
      * @Author tuzhaoliang
      * @Date 2020/9/17 11:17
      **/
    private void addInstanceTask(Task dbTask) {
        // 开启任务
        try {
            Class<? extends cn.hutool.cron.task.Task> handlerClass = (Class<? extends cn.hutool.cron.task.Task>)
                    Class.forName(dbTask.getHandler().getHandlerClass());
            cn.hutool.cron.task.Task localTask = this.applicationContext.getBean(handlerClass);
            CronUtil.schedule(dbTask.getId().toString(), dbTask.getCron(), localTask);
            CronUtil.setMatchSecond(true);
        } catch (Exception e) {
            log.error("开启任务失败", e);
            dbTask.setState(TaskState.STOPPED);
            this.save(dbTask);
        }
    }

    /**
      * @Description 删除Instance任务
      * @Author tuzhaoliang
      * @Date 2020/9/17 15:41
      **/
    private void deleteInstanceTask(Task dbTask) {
        CronUtil.remove(dbTask.getId().toString());
    }

    /**
      * @Description 更新任务时间
      * @Author tuzhaoliang
      * @Date 2020/9/17 15:52
      **/
    private void updateInstanceTask(Task task) {
        CronUtil.updatePattern(task.getId().toString(), new CronPattern(task.getCron()));
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    /**
      * @Description 初始化NextFireTime
      * @Author tuzhaoliang
      * @Date 2020/9/16 10:46
      **/
    private void initTaskNextFireTime(Task task, LocalDateTime defaultTime) {
        if (defaultTime != null) {
            task.setNextFireTime(defaultTime);
            return;
        }
        CronPattern cronPattern = new CronPattern(task.getCron());
        // 下面这个方法如果不增加一个当前时间偏移1s，那么这里计算的下次执行时间跟本次执行时间就会一样，这样明显不符合常理
        Date date = CronPatternUtil.nextDateAfter(cronPattern, DateUtil.offset(new Date(), DateField.SECOND, 1), true);
        task.setNextFireTime(LocalDateTimeUtil.of(date));
    }


}
