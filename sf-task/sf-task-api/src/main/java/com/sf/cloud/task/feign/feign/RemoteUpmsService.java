package com.sf.cloud.task.feign.feign;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.pig4cloud.pig.common.core.constant.SecurityConstants;
import com.pig4cloud.pig.common.core.constant.ServiceNameConstants;
import com.pig4cloud.pig.common.core.util.R;
import com.sf.cloud.task.feign.feign.factory.RemoteUpmsServiceFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

/**
  * @Author tuzhaoliang
  * @Date 2020/9/15 14:08
  **/
@FeignClient(contextId = "remoteUpmsService", value = ServiceNameConstants.UMPS_SERVICE,
        fallbackFactory = RemoteUpmsServiceFallbackFactory.class)
public interface RemoteUpmsService {

    /**
     * 通过字典类型查找字典
     * @param type 类型
     * @return 同类型字典
     */
    @GetMapping("/dict/type/{type}")
    R getDictByType(@PathVariable("type") String type, @RequestHeader(SecurityConstants.FROM) String from);

	@GetMapping("/role/list")
	R listRoles();
}
