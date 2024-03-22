package com.pig4cloud.pig.mocuser.feign;

import com.pig4cloud.pig.common.core.constant.SecurityConstants;
import com.pig4cloud.pig.common.core.util.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
@Service
@Component
@FeignClient(contextId = "mocuser",name = "mocuser-biz")
public interface RemotemocUser {
	@PostMapping("/api/login")
	R login(@RequestBody String name,@RequestBody String pwd);
//	@PostMapping("/api/loginout")
//	R loginout(@RequestBody String phone,@RequestBody String pwd);
//	@PostMapping("/api/login")
//	R reg(@RequestBody String phone,@RequestBody String pwd);
//	@PostMapping("/api/login")
//	R updateByUuid(@RequestBody String phone,@RequestBody String pwd);
}

