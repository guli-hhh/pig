package com.sf.cloud.task.task.service;

import com.sf.cloud.task.task.domain.po.Project;

import java.util.Optional;

/**
  * @Author tuzhaoliang
  * @Date 2020/9/8 17:39
  **/
public interface ProjectService extends BaseService<Project,Long> {
	Optional<Project> findByName(String projectName);
}
