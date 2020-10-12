package com.sf.cloud.task.task.service.impl;

import com.sf.cloud.task.task.dao.BaseRepository;
import com.sf.cloud.task.task.dao.SmsCountRepository;
import com.sf.cloud.task.task.domain.po.SmsCount;
import com.sf.cloud.task.task.service.SmsCountService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class SmsCountServiceImpl implements SmsCountService {

	private final SmsCountRepository smsCountRepository;

	@Override
	public BaseRepository<SmsCount, Long> getRepository() {
		return this.smsCountRepository;
	}

	@Override
	public void setRemain(Long remainCount) {
		List<SmsCount> smsCounts = this.getRepository().findAll();
		if (smsCounts.isEmpty()) {
			SmsCount smsCount = SmsCount.builder()
				.remain(remainCount)
				.hasSend(0L)
				.build();
			this.getRepository().save(smsCount);
		}
		SmsCount smsCount = smsCounts.get(0);
		smsCount.setRemain(remainCount);
		this.getRepository().save(smsCount);
	}

	/**
	 * @Description 减少一条剩余量
	 * @Author tuzhaoliang
	 * @Date 2020/10/10 15:47
	 **/
	@Override
	public void reduceOne() {
		List<SmsCount> smsCounts = this.getRepository().findAll();
		if (smsCounts.isEmpty()) {
			return;
		}
		SmsCount smsCount = smsCounts.get(0);
		if (smsCount.getRemain() == 0L) {
			return;
		}
		smsCount.setRemain(smsCount.getRemain() - 1L);
		this.getRepository().save(smsCount);
	}

	/**
	 * @Description 获取短信剩余条数
	 * @Author tuzhaoliang
	 * @Date 2020/10/10 15:46
	 **/
	@Override
	public Long getRemain() {
		List<SmsCount> smsCounts = this.getRepository().findAll();
		if (smsCounts.isEmpty()) {
			return 0L;
		}
		return Optional.of(smsCounts.get(0).getRemain()).orElse(0L);
	}

	/**
	 * @Description 获取已发送条数
	 * @Return
	 * @Author tuzhaoliang
	 * @Date 2020/10/10 16:57
	 **/
	@Override
	public Long getHasSendCount() {
		List<SmsCount> smsCounts = this.getRepository().findAll();
		if (smsCounts.isEmpty()) {
			return 0L;
		}
		return Optional.of(smsCounts.get(0).getHasSend()).orElse(0L);
	}
}
