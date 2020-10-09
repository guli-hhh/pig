package com.sf.cloud.task;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import com.sf.cloud.task.task.constant.MessageState;
import com.sf.cloud.task.task.constant.Platform;
import com.sf.cloud.task.task.dao.DataSourceRepository;
import com.sf.cloud.task.task.dao.MessageRepository;
import com.sf.cloud.task.task.domain.po.*;
import com.sf.cloud.task.task.service.HandlerService;
import com.sf.cloud.task.task.service.MessageService;
import com.sf.cloud.task.task.service.ProjectService;
import com.sf.cloud.task.task.service.TaskService;
import org.hibernate.annotations.Tuplizer;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.test.context.junit4.SpringRunner;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

@SpringBootTest
@RunWith(SpringRunner.class)
public class JPATest {

    @Autowired
    private DataSourceRepository dataSourceRepository;

    @Autowired
    private MessageService messageService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private HandlerService handlerService;

    @Autowired
    private TaskService taskService;

	@Autowired
	private MessageRepository messageRepository;

    @Test
    public void testManyToOne() {
        List<DataSource> all = dataSourceRepository.findAll();
        System.out.println(all);
    }

    @Test
    public void testInsertManyToOne() {
        DataSource dataSource = DataSource.builder().name("武大数据源1")
                .platform(Platform.JAVA_ENERGY)
                .username("root")
                .password("root")
                .driverClass("com.driverClass")
                .url("java://mysql")
                .build();
        dataSourceRepository.save(dataSource);
    }

    @Test
    public void saveMessage() {
        Project project = projectService.findAll().get(0);
        Handler handler = handlerService.findAll().get(0);
        Message message = Message.builder()
                .platform(Platform.JAVA_ENERGY)
                .message("(${projectName}最近 ${recentDays} 天 ${deviceType} 离线)位置: ${address}, ${gatherAddress}, 离线数量: ${offLineNum}, 总数量: ${totalNum}。")
                .state(MessageState.NOT_SEND)
                .build();
        messageService.save(message);
    }

    @Test
    public void findTask() {
        List<Task> tasks = taskService.findAll();
        System.out.println(tasks);
    }

    @Test
    public void findDataSource() {
        List<DataSource> all = dataSourceRepository.findAll();
        System.out.println(all);
    }

	@Test
	public void testFind() {
		Specification<Message> specification = new Specification<Message>() {
			@Override
			public Predicate toPredicate(Root root, CriteriaQuery query, CriteriaBuilder cb) {
				//增加筛选条件
				Predicate predicate = cb.conjunction();
				predicate.getExpressions().add(cb.equal(root.get("state"), MessageState.NOT_SEND));
				// 7天以内
				LocalDateTime ago = LocalDateTimeUtil.offset(LocalDateTimeUtil.now(), -7, ChronoUnit.DAYS);
				Date agoDate = Date.from(ago.atZone(ZoneId.systemDefault()).toInstant());
				predicate.getExpressions().add(cb.greaterThanOrEqualTo(root.get("createTime").as(Date.class), agoDate));
				return predicate;
			}
		};
		List<Message> all = messageRepository.findAll(specification);
		System.out.println(all);
	}
}
