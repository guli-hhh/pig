package com.sf.cloud.task.task.service;

import com.sf.cloud.task.task.domain.po.Message;

import java.util.List;

public interface MessageService extends BaseService<Message,Long> {

	/**
	  * @Description 查询7天内未发送的消息
	  * @Author tuzhaoliang
	  * @Date 2020/10/9 9:57
	  **/
	List<Message> findNotSend();
}
