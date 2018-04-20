package com.github.pig.cms.blog;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.feign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@EnableWebMvc
@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
@ComponentScan(basePackages = {"com.github.pig.cms.blog", "com.github.pig.common.bean"})
public class PigCmsBlogServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(PigCmsBlogServiceApplication.class, args);
    }
}
