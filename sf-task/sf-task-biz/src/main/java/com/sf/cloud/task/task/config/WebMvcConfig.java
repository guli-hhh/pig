package com.sf.cloud.task.task.config;

import com.pig4cloud.pig.common.core.config.WebMvcConfiguration;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import java.util.List;

@Configuration
@RequiredArgsConstructor
public class WebMvcConfig extends WebMvcConfiguration {

    private final TaskMethodArgumentResolver taskMethodArgumentResolver;

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
        argumentResolvers.add(taskMethodArgumentResolver);
        super.addArgumentResolvers(argumentResolvers);
    }
}
