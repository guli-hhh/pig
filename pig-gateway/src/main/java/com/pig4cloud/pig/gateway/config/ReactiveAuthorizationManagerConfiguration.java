package com.pig4cloud.pig.gateway.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authorization.AuthorizationDecision;
import org.springframework.security.authorization.ReactiveAuthorizationManager;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.security.web.server.authorization.AuthorizationContext;
import reactor.core.publisher.Mono;

/**
 * 网关禁用 Security
 *
 * @author xuxiaowei
 * @since 3.6.4
 */
@Slf4j
@Configuration
public class ReactiveAuthorizationManagerConfiguration implements ReactiveAuthorizationManager<AuthorizationContext> {

	@Override
	public Mono<AuthorizationDecision> check(Mono<Authentication> authentication, AuthorizationContext object) {
		return Mono.just(new AuthorizationDecision(true));
	}

	@Bean
	public SecurityWebFilterChain springSecurityFilterChain(ServerHttpSecurity http) {

		http.formLogin().disable();
		http.csrf().disable();
		http.cors().disable();

		return http.build();
	}

}
