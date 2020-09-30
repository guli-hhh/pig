package com.sf.cloud.task;

import com.sf.cloud.task.task.dao.DataSourceRepository;
import com.sf.cloud.task.task.domain.po.DataSource;
import com.sf.cloud.task.task.domain.vo.DataSourceVo;
import com.sf.cloud.task.task.service.DataSourceService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Optional;

@SpringBootTest
@RunWith(SpringRunner.class)
public class POVOTest {

    @Autowired
    DataSourceRepository dataSourceRepository;

    @Autowired
    DataSourceService dataSourceService;

}
