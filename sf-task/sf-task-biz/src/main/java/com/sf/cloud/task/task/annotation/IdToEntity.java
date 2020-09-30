package com.sf.cloud.task.task.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
  * @Description
  * @Author tuzhaoliang
  * @Date 2020/9/11 14:11
  *
 * 自定义 参数解析 注解  注意:使用@RequestBody注解 则本注解失效
 * 注解 参数
 * 此注解参数包含如platformId,并且被解析对象中包含platform字段时，将自动填充platform字段
 */
@Target({ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface IdToEntity {

    Class genericCalss() default Object.class;
}
