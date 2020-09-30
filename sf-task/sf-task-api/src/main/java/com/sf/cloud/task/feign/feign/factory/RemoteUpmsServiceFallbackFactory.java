package com.sf.cloud.task.feign.feign.factory;

import com.sf.cloud.task.feign.feign.RemoteUpmsService;
import com.sf.cloud.task.feign.feign.fallback.RemoteUpmsServiceFallbackImpl;
import feign.hystrix.FallbackFactory;
import org.springframework.stereotype.Component;

@Component
public class RemoteUpmsServiceFallbackFactory implements FallbackFactory<RemoteUpmsService> {
    @Override
    public RemoteUpmsService create(Throwable throwable) {
        RemoteUpmsServiceFallbackImpl remoteUpmsServiceFallback = new RemoteUpmsServiceFallbackImpl();
        remoteUpmsServiceFallback.setCause(throwable);
        return remoteUpmsServiceFallback;
    }
}
