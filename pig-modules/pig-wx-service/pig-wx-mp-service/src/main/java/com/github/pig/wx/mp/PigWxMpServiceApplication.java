package com.github.pig.wx.mp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.feign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
@ComponentScan(basePackages = {"com.github.pig.wx.mp", "com.github.pig.common.bean"})
public class PigWxMpServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(PigWxMpServiceApplication.class, args);
    }
}
