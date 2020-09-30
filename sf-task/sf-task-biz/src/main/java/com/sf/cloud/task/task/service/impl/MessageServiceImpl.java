package com.sf.cloud.task.task.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import com.sf.cloud.task.task.constant.MessageState;
import com.sf.cloud.task.task.dao.BaseRepository;
import com.sf.cloud.task.task.dao.MessageRepository;
import com.sf.cloud.task.task.domain.po.Message;
import com.sf.cloud.task.task.service.MessageService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

/**
  * @Description 消息服务类
  * @Author tuzhaoliang
  * @Date 2020/9/18 8:46
  **/
@RequiredArgsConstructor
@Service
public class MessageServiceImpl implements MessageService {

    private final MessageRepository messageRepository;

    @Override
    public BaseRepository<Message, Long> getRepository() {
        return messageRepository;
    }

    @Override
    public Message save(Message message) {
        if (message.getState() == null) {
            message.setState(MessageState.NOT_SEND);
        }
        if (isNeedToSave(message)) {
            getRepository().save(message);
        }
        return message;
    }

    @Override
    public <S extends Message> List<S> saveAll(Iterable<S> entities) {

        List<S> needToSaveMessage = StreamSupport.stream(entities.spliterator(), false)
                .filter(this::isNeedToSave)
                .collect(Collectors.toList());

        needToSaveMessage.forEach(entity -> {
            if (entity.getState() == null) {
                entity.setState(MessageState.NOT_SEND);
            }
        });
        return getRepository().saveAll(needToSaveMessage);
    }

    private boolean isNeedToSave(Message message) {
        Message preMessageExample = Message.builder()
                .projectName(message.getProjectName())
                .platform(message.getPlatform())
                .handlerName(message.getHandlerName())
                .message(message.getPlace())
                .build();
        PageRequest pageable =
                PageRequest.of(0,
                        1,
                        Sort.by(Sort.Direction.DESC, "createTime"));
        ExampleMatcher matcher = ExampleMatcher.matching()
                .withMatcher("message", ExampleMatcher.GenericPropertyMatcher::contains);
        Page<Message> similarMessagePage
                = this.findAll(Example.of(preMessageExample, matcher), pageable);
        if (similarMessagePage.getContent().isEmpty()) {
            // 没有相似的消息 直接存入
            return true;
        }
        // 有相似的消息，判断时间 决定是否存入
        Message similarMessage = similarMessagePage.getContent().get(0);
        Duration between = LocalDateTimeUtil.between(similarMessage.getCreateTime()
                , LocalDateTimeUtil.now());
        long betweenDays = between.toDays();
        return betweenDays > 7;
    }

}
