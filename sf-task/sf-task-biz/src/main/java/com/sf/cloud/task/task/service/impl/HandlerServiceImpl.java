package com.sf.cloud.task.task.service.impl;

import com.sf.cloud.task.task.dao.BaseRepository;
import com.sf.cloud.task.task.dao.HandlerRepository;
import com.sf.cloud.task.task.domain.po.Handler;
import com.sf.cloud.task.task.service.HandlerService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
  * @Author tuzhaoliang
  * @Date 2020/9/8 16:08
  **/
@RequiredArgsConstructor
@Service
public class HandlerServiceImpl implements HandlerService {

    private final HandlerRepository handlerRepository;

    @Override
    public BaseRepository<Handler, Long> getRepository() {
        return handlerRepository;
    }
}
