package com.pig4cloud.pig.common.application;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;

/**
 * Application自动配置
 *
 * @author KingDragon
 * @date 2021/7/21 10:03
 */
@Configuration
@ConditionalOnProperty(name = "spring.application.enabledAuto", matchIfMissing = true)
public class PigApplicationAutoConfiguration {
	// TODO 自动配置服务相关，例如：@EnableDiscoveryClient

}
