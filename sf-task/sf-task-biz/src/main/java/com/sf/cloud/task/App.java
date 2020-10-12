package com.sf.cloud.task;

import cn.hutool.core.lang.Console;
import cn.hutool.cron.CronUtil;
import cn.hutool.cron.TaskTable;
import cn.hutool.cron.task.Task;
import com.pig4cloud.pig.common.security.annotation.EnablePigFeignClients;
import com.pig4cloud.pig.common.security.annotation.EnablePigResourceServer;
import com.sf.cloud.task.task.job.listener.TimeListener;
import com.sf.cloud.task.task.service.TaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.SpringApplicationRunListener;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.web.context.request.RequestContextHolder;

import java.util.List;

/**
 * @author pig archetype
 * <p>
 * 项目启动类
 */
@RequiredArgsConstructor
@EnableJpaAuditing
@EnablePigFeignClients(basePackages = {"com.sf.cloud.task", "com.pig4cloud.pig"})
@EnablePigResourceServer
@SpringCloudApplication
public class App implements ApplicationRunner {

    private final TaskService taskService;

    private final TimeListener timeListener;

    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }

    @Override
    public void run(ApplicationArguments args) {
		RequestContextHolder.setRequestAttributes(RequestContextHolder.getRequestAttributes(), true);
		// 每30分钟从后台获取任务，重新初始化任务
		CronUtil.schedule("0/20 * * * * ? *", (Task) taskService::initLocalTask);

		// 支持秒级别定时任务
		CronUtil.setMatchSecond(true);
		CronUtil.start();
    }
}
