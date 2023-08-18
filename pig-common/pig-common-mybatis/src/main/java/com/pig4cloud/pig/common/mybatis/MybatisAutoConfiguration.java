/*
 * Copyright (c) 2020 pig4cloud Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.pig4cloud.pig.common.mybatis;

import com.mybatisflex.core.audit.AuditManager;
import com.mybatisflex.core.mybatis.FlexConfiguration;
import com.mybatisflex.spring.boot.ConfigurationCustomizer;
import org.springframework.context.annotation.Configuration;

/**
 * @author Olver
 * @date: 2023-8-16
 * <p>
 * mybatis flex 统一配置
 */
@Configuration(proxyBeanMethods = false)
public class MybatisAutoConfiguration implements ConfigurationCustomizer {

	/**
	 * mybatis flex 统一配置
	 * @param configuration
	 */
	@Override
	public void customize(FlexConfiguration configuration) {
		//开启sql日志审计
		AuditManager.setAuditEnable(true);
		//开启则开启 多租户插件
//		MessageCollector collector = new ConsoleMessageCollector();
//		AuditManager.setMessageCollector(collector);
//		//租户配置
//		TenantManager.setTenantFactory(() -> {
//			//通过这里返回当前租户 ID
//			return new String[]{"000000"};
//		});
	}

}
