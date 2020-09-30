package com.sf.cloud.task;

import com.sf.cloud.task.task.domain.po.Task;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.lang.reflect.TypeVariable;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
@RunWith(SpringRunner.class)
public class ListReflectionTest {

    @Test
    public void getTrueClass() {
        List<Task> tasks = new ArrayList<>();
        Class<? extends List> tasksClass = tasks.getClass();
        TypeVariable<? extends Class<? extends List>>[] typeParameters = tasksClass.getTypeParameters();
        System.out.println(typeParameters);
    }
}
