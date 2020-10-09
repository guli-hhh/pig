package com.sf.cloud.task.task.job;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.cron.task.Task;
import com.pig4cloud.pig.admin.api.entity.SysUser;
import com.pig4cloud.pig.common.core.util.R;
import com.sf.cloud.task.feign.feign.RemoteUpmsService;
import com.sf.cloud.task.task.constant.MessageState;
import com.sf.cloud.task.task.domain.po.Message;
import com.sf.cloud.task.task.domain.po.Project;
import com.sf.cloud.task.task.service.MessageService;
import com.sf.cloud.task.task.service.ProjectService;
import com.sf.cloud.task.task.utils.MessageUtil;
import com.sf.cloud.task.task.utils.SpringBeanUtils;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

@Component
@Slf4j
public class SmsTask implements Task {

	private MessageService messageService;

	private ProjectService projectService;

	private RemoteUpmsService remoteUpmsService;

	public SmsTask() {
		messageService = SpringBeanUtils.getBean(MessageService.class);
		projectService = SpringBeanUtils.getBean(ProjectService.class);
		remoteUpmsService = SpringBeanUtils.getBean(RemoteUpmsService.class);
	}

    /**
     * 执行作业
     * <p>
     * 作业的具体实现需考虑异常情况，默认情况下任务异常在监听中统一监听处理，如果不加入监听，异常会被忽略<br>
     * 因此最好自行捕获异常后处理
     */
    @Override
    public void execute() {
		messageService = SpringBeanUtils.getBean(MessageService.class);
		projectService = SpringBeanUtils.getBean(ProjectService.class);
		remoteUpmsService = SpringBeanUtils.getBean(RemoteUpmsService.class);
        // 获取7天内未发送的短信
		List<Message> notSend = messageService.findNotSend();
		for (Message message : notSend) {
			// 获取短信的平台
			Optional<Project> projectOptional = projectService.findByName(message.getProjectName());
			if (!projectOptional.isPresent()) {
				continue;
			}
			Project project = projectOptional.get();
			if (project.getRoleIds() == null || project.getRoleIds().isEmpty()) {
				continue;
			}
			List<SysUser> users = this.getUsers(project);

			for (SysUser user : users) {
//				MessageUtil.send(message.getMessage(), user.getPhone());
				log.info("发送短信给:{},{}", user.getUsername(), user.getPhone());
				log.info(message.getMessage());
			}

		}
	}

	/**
	  * @Description 获取项目相关负责人
	  * @Author tuzhaoliang
	  * @Date 2020/10/9 13:57
	  **/
	@SneakyThrows
	private List<SysUser> getUsers(Project project) {
		List<SysUser> users = new ArrayList<>();
		for (Integer roleId : project.getRoleIds()) {
			List<Map> data = (List<Map>) remoteUpmsService.getUserByRoleId(roleId).getData();
			if (data.isEmpty()) {
				continue;
			}
			List<SysUser> usersByRoleId = data.stream()
				.map(map -> BeanUtil.mapToBean(map, SysUser.class, true))
				.collect(Collectors.toList());
			users.addAll(usersByRoleId);
		}
		return users;
	}
}
