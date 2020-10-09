package com.sf.cloud.task.task.utils;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

/**
  * @Author tuzhaoliang
  * @Date 2020/9/23 10:50
  **/
@Component
public class SpringBeanUtils<T> implements ApplicationContextAware {

    private static ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        SpringBeanUtils.applicationContext = applicationContext;
    }

    public static <T> T  getBean(Class<T> clazz) {
        return applicationContext != null?applicationContext.getBean(clazz):null;
    }

    public static Object getBeanByString(String beanName) throws BeansException {
        return applicationContext.getBean(beanName);
    }

}
