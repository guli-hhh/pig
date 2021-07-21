package com.pig4cloud.pig.common.application.processor;

import org.springframework.beans.factory.config.YamlPropertiesFactoryBean;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.env.EnvironmentPostProcessor;
import org.springframework.boot.env.OriginTrackedMapPropertySource;
import org.springframework.core.Ordered;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MutablePropertySources;
import org.springframework.core.env.PropertySource;
import org.springframework.core.io.ClassPathResource;

import java.util.Collections;
import java.util.Map;
import java.util.Objects;
import java.util.Properties;

/**
 * 自动加载基础配置与环境配置
 *
 * @author KingDragon
 * @date 2021/7/21 10:21
 */
public class PigEnvPostProcessor implements EnvironmentPostProcessor, Ordered {

	private static final String[] PIG_CONFIG_LIST = new String[]{
			"pig-application.yml"
	};

	private static final String PIG_PROFILES_ACTIVE = "spring.profiles.active";

	private static final String PIG_APPLICATION_CONFIG = "config/%s/%s";

	private static final String PIG_BASE_APPLICATION_CONFIG = "config/pig-base-application.yml";

	@Override
	public void postProcessEnvironment(ConfigurableEnvironment environment, SpringApplication application) {
		MutablePropertySources propertySources = environment.getPropertySources();
		String active = environment.getProperty(PIG_PROFILES_ACTIVE);
		if (Objects.nonNull(active)) {
			// 加载基本配置
			loadConfig(PIG_BASE_APPLICATION_CONFIG, propertySources);
			// 加载环境配置集
			for (String profile : PIG_CONFIG_LIST) {
				loadConfig(String.format(PIG_APPLICATION_CONFIG, active, profile), propertySources);
			}
		}
	}

	/**
	 * 加载配置
	 *
	 * @param profilePath		配置文件路径
	 * @param propertySources	配置源
	 */
	private void loadConfig(String profilePath, MutablePropertySources propertySources) {
		YamlPropertiesFactoryBean yaml = new YamlPropertiesFactoryBean();
		yaml.setResources(new ClassPathResource(profilePath));
		Properties properties = yaml.getObject();
		// 创建配置源
		PropertySource<Map<String, Object>> propertySource = new OriginTrackedMapPropertySource(profilePath,
				Collections.unmodifiableMap(Objects.requireNonNull(properties)), true);
		// 添加配置源到末尾，优先级最低
		propertySources.addLast(propertySource);
	}

	@Override
	public int getOrder() {
		return Ordered.LOWEST_PRECEDENCE;
	}
}
