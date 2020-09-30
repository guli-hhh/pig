package com.sf.cloud.task.task.utils;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import java.util.List;

public class PageUtil {

    /**
      * @Description 获取新分页对象
      * @Return
      * @Author tuzhaoliang
      * @Date 2020/9/10 14:33
      **/
    public static <T> PageImpl<T> getPage(List<T> content, PageRequest pageRequest, long total) {
        return new PageImpl(content
                , pageRequest
                , total);
    }

    public static <T> PageImpl<T> getPage(List<T> content, Page oldPage) {
        return new PageImpl(content
                , PageRequest.of(oldPage.getNumber(), oldPage.getSize(), oldPage.getSort())
                , oldPage.getTotalElements());
    }
}
