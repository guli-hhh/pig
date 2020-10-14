package com.sf.cloud.task;

import com.sf.cloud.task.task.utils.MessageUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class SmsTest {

	@Test
	public void testSend() {
		String msg = "(公司平台最近电表离线)位置: 盛帆工业园..1号楼集中器, 4201466500, 离线数量: 81, 总数量: 81。";
		MessageUtil.send(msg, "15172445210");

	}
}
