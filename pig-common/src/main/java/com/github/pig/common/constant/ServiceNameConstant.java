package com.github.pig.common.constant;

/**
 * @author lengleng
 * @date 2018/1/25
 * 服务名称
 */
public interface ServiceNameConstant {
    /**
     * 认证服务的SERVICEID（zuul 配置的对应）
     */
    String AUTH_SERVICE = "pig-auth";

    /**
     * UMPS模块
     */
    String UMPS_SERVICE = "pig-upms-service";

    /**
     * WX MP 模块
     */
    String WX_MP_SERVICE = "pig-wx-mp-service";

    /**
     * CMS BLOG MP 模块
     */
    String CMS_BLOG_SERVICE = "pig-cms-blog-service";
}
