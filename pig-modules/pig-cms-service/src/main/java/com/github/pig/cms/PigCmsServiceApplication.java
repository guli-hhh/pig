package com.github.pig.cms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableAsync;

@EnableAsync
@EnableDiscoveryClient
@ComponentScan(basePackages = {"com.github.pig.cms", "com.github.pig.common.bean"})
@SpringBootApplication
public class PigCmsServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(PigCmsServiceApplication.class, args);
    }
}
