package com.sf.cloud.task.task.dao;

import com.sf.cloud.task.task.domain.po.SmsCount;
import org.springframework.stereotype.Repository;

@Repository
public interface SmsCountRepository extends BaseRepository<SmsCount,Long> {
}
