package com.sf.cloud.task.task.job;

import cn.hutool.cron.task.Task;
import com.pig4cloud.pig.admin.api.entity.SysUser;
import com.pig4cloud.pig.admin.api.feign.RemoteUserService;
import com.pig4cloud.pig.common.core.constant.SecurityConstants;
import com.pig4cloud.pig.common.core.util.R;
import com.sf.cloud.task.task.domain.po.Message;
import com.sf.cloud.task.task.domain.po.Project;
import com.sf.cloud.task.task.service.MessageService;
import com.sf.cloud.task.task.service.ProjectService;
import com.sf.cloud.task.task.service.SmsCountService;
import com.sf.cloud.task.task.utils.MessageUtil;
import com.sf.cloud.task.task.utils.SpringBeanUtils;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
@Slf4j
public class SmsTask implements Task {

	private MessageService messageService;

	private ProjectService projectService;

	private RemoteUserService remoteUserService;

	private SmsCountService smsCountService;

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
		remoteUserService = SpringBeanUtils.getBean(RemoteUserService.class);
		smsCountService = SpringBeanUtils.getBean(SmsCountService.class);
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
				MessageUtil.send(message.getMessage(), user.getPhone());
				smsCountService.useOne();
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
			R usersByRoleId = remoteUserService.getUsersByRoleId(roleId, SecurityConstants.FROM_IN);
			if (usersByRoleId == null) {
				continue;
			}
			List sysUsers = (List) usersByRoleId.getData();
			if (null == sysUsers || sysUsers.isEmpty()) {
				continue;
			}
			users.addAll(sysUsers);
		}
		return users;
	}
}
