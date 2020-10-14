package com.sf.cloud.task.task.service;

import com.sf.cloud.task.task.domain.po.SmsCount;

public interface SmsCountService extends BaseService<SmsCount,Long> {

	/**
	  * @Description 设置短信剩余条数
	  * @Author tuzhaoliang
	  * @Date 2020/10/10 15:46
	  **/
	void setRemain(Long remainCount);


	/**
	  * @Description 减少一条剩余量
	  * @Author tuzhaoliang
	  * @Date 2020/10/10 15:47
	  **/
	void useOne();

	/**
	 * @Description 获取短信剩余条数
	 * @Author tuzhaoliang
	 * @Date 2020/10/10 15:46
	 **/
	Long getRemain();

	/**
	  * @Description 获取已发送条数
	  * @Return
	  * @Author tuzhaoliang
	  * @Date 2020/10/10 16:57
	  **/
	Long getHasSendCount();
}
