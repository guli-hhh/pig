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

package com.pig4cloud.pig.auth.config;

import com.pig4cloud.pig.auth.endpoint.TokenController;
import com.pig4cloud.pig.auth.support.core.FormIdentityLoginConfigurer;
import com.pig4cloud.pig.auth.support.core.PigDaoAuthenticationProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.oauth2.server.authorization.OAuth2Utils;
import org.springframework.security.oauth2.core.OAuth2Token;
import org.springframework.security.oauth2.server.authorization.OAuth2AuthorizationService;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClientRepository;
import org.springframework.security.oauth2.server.authorization.config.ProviderSettings;
import org.springframework.security.oauth2.server.authorization.token.OAuth2TokenGenerator;
import org.springframework.security.web.SecurityFilterChain;

/**
 * 服务安全相关配置
 *
 * @author lengleng
 * @date 2022/1/12
 */
@EnableWebSecurity(debug = true)
public class WebSecurityConfiguration {

	private TokenController tokenController;

	@Autowired
	public void setTokenController(TokenController tokenController) {
		this.tokenController = tokenController;
	}

	/**
	 * spring security 默认的安全策略
	 * @param http security注入点
	 * @return SecurityFilterChain
	 * @throws Exception
	 */
	@Bean
	SecurityFilterChain defaultSecurityFilterChain(HttpSecurity http) throws Exception {
		http.authorizeRequests(authorizeRequests -> authorizeRequests.antMatchers("/token/*").permitAll()// 开放自定义的部分端点
				.anyRequest().authenticated()).headers().frameOptions().sameOrigin()// 避免iframe同源无法登录
				.and().apply(new FormIdentityLoginConfigurer()); // 表单登录个性化
		// 处理 UsernamePasswordAuthenticationToken
		http.authenticationProvider(new PigDaoAuthenticationProvider());

		// Q：为何使用 HttpSecurity 获取 Bean 然后放入 Controller 中？而不是直接在 Controller 中获取下列 Bean？
		// A：因为配置方式不同，
		// 如：有人使用创建 Bean 的形式来创建下列 Bean，还有人直接操作 HttpSecurity 来设置 Bean（这两种方式在 Security 中默认都支持），
		// 为了兼容这两种防止，所以采用了下列做法，这也是 Security 中的默认做法

		RegisteredClientRepository registeredClientRepository = OAuth2Utils.getRegisteredClientRepository(http);
		OAuth2AuthorizationService authorizationService = OAuth2Utils.getAuthorizationService(http);
		OAuth2TokenGenerator<? extends OAuth2Token> tokenGenerator = OAuth2Utils.getTokenGenerator(http);
		ProviderSettings providerSettings = OAuth2Utils.getProviderSettings(http);

		tokenController.setRegisteredClientRepository(registeredClientRepository);
		tokenController.setAuthorizationService(authorizationService);
		tokenController.setTokenGenerator(tokenGenerator);
		tokenController.setProviderSettings(providerSettings);

		return http.build();
	}

	/**
	 * 暴露静态资源
	 *
	 * https://github.com/spring-projects/spring-security/issues/10938
	 * @param http
	 * @return
	 * @throws Exception
	 */
	@Bean
	@Order(0)
	SecurityFilterChain resources(HttpSecurity http) throws Exception {
		http.requestMatchers((matchers) -> matchers.antMatchers("/actuator/**", "/css/**", "/error"))
				.authorizeHttpRequests((authorize) -> authorize.anyRequest().permitAll()).requestCache().disable()
				.securityContext().disable().sessionManagement().disable();
		return http.build();
	}

}
