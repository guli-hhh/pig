package com.pig4cloud.pig.auth.support.core;

import com.pig4cloud.pig.auth.support.handler.FormAuthenticationFailureHandler;
import com.pig4cloud.pig.auth.support.handler.SsoLogoutSuccessHandler;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;

/**
 * 基于授权码模式 统一认证登录 spring security and sas 都可以使用 所以抽取成 HttpConfigurer
 *
 * @author lengleng
 * @since 2022-06-04
 */
public final class FormIdentityLoginConfigurer
		extends AbstractHttpConfigurer<FormIdentityLoginConfigurer, HttpSecurity> {

	@Override
	public void init(HttpSecurity http) throws Exception {
		http.formLogin(formLogin -> {
			formLogin.loginPage("/token/login");
			formLogin.loginProcessingUrl("/token/form");
			formLogin.failureHandler(new FormAuthenticationFailureHandler());

		}).logout() // SSO登出成功处理
				.logoutSuccessHandler(new SsoLogoutSuccessHandler()).deleteCookies("JSESSIONID")
				.invalidateHttpSession(true).and().csrf().disable();
	}

}
