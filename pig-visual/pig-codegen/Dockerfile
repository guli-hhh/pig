FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER wangiegie@gmail.com

ENV TZ=Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir -p /pig-codegen

WORKDIR /pig-codegen

EXPOSE 5002

ADD ./target/pig-codegen.jar ./

CMD sleep 60;java -Xms512m -Xmx512m -Xmn256m -Xss256k -XX:+UseConcMarkSweepGC -Djava.security.egd=file:/dev/./urandom -jar pig-codegen.jar
