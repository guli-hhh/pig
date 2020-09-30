package com.sf.cloud.task;

import cn.hutool.core.util.StrUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class StringTest {

    @Test
    public void testSubStr() {
        final String ID_END = "Id";
        String s = "platformId";
        String sub = StrUtil.sub(s, 0, s.length() - ID_END.length());
        System.out.println(sub);
    }
}
