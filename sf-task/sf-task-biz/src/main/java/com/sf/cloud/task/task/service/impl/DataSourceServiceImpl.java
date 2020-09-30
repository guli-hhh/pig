package com.sf.cloud.task.task.service.impl;

import com.sf.cloud.task.task.dao.BaseRepository;
import com.sf.cloud.task.task.dao.DataSourceRepository;
import com.sf.cloud.task.task.domain.po.DataSource;
import com.sf.cloud.task.task.service.DataSourceService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @Author tuzhaoliang
 * @Date 2020/9/8 17:39
 **/
@RequiredArgsConstructor
@Service
public class DataSourceServiceImpl implements DataSourceService {

    private final DataSourceRepository dataSourceRepository;

    @Override
    public BaseRepository<DataSource, Long> getRepository() {
        return dataSourceRepository;
    }

}
