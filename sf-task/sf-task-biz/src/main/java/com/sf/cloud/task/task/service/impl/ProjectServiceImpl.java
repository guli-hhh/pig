package com.sf.cloud.task.task.service.impl;

import com.sf.cloud.task.task.dao.BaseRepository;
import com.sf.cloud.task.task.dao.ProjectRepository;
import com.sf.cloud.task.task.domain.po.Project;
import com.sf.cloud.task.task.service.ProjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
  * @Author tuzhaoliang
  * @Date 2020/9/8 17:39
  **/
@RequiredArgsConstructor
@Service
public class ProjectServiceImpl implements ProjectService {

    private final ProjectRepository projectRepository;

    @Override
    public BaseRepository<Project, Long> getRepository() {
        return projectRepository;
    }
}
