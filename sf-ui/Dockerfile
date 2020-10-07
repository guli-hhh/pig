# FROM nginx
# VOLUME /tmp
# ENV LANG en_US.UTF-8
# ADD ./dist/ /usr/share/nginx/html/
# EXPOSE 80
# EXPOSE 443

# node镜像
FROM node
# 维护者信息
#MAINTAINER zhengqing "960869719@qq.com"

RUN echo "-------------------- web环境配置 --------------------"

# 指定接下来的工作路径为/app  - 类似于cd命令
WORKDIR /app
# 拷贝前端项目到app目录下
COPY ./ .

# 设置淘宝npm镜像
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
# 安装依赖
RUN cnpm install

# 前端项目运行命令
#CMD ["npm","run","dev"]
