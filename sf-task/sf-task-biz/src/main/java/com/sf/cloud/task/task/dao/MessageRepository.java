package com.sf.cloud.task.task.dao;

import com.sf.cloud.task.task.domain.po.Message;
import org.springframework.stereotype.Repository;

/**
 * @author tuzhaoliang
 */
@Repository
public interface MessageRepository extends BaseRepository<Message,Long> {
}
