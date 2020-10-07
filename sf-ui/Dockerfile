FROM nginx
VOLUME /tmp
ENV LANG en_US.UTF-8
ADD ./dist/ /usr/share/nginx/html/
#用本地的 default.conf 配置来替换nginx镜像里的默认配置
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
EXPOSE 443
