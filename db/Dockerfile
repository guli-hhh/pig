FROM mysql:8.0.20

MAINTAINER lengleng(wangiegie@gmail.com)

ENV TZ Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# && echo $TZ > /etc/timezone

# 除了新部署需要初始化 其他时候不需要初始化
#COPY ./pig.sql /docker-entrypoint-initdb.d
#
#COPY ./pig_codegen.sql /docker-entrypoint-initdb.d
#
#COPY ./pig_config.sql /docker-entrypoint-initdb.d
