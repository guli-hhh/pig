FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER wangiegie@gmail.com

ENV TZ=Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir -p /pig-upms

WORKDIR /pig-upms

EXPOSE 4000

ADD ./target/pig-upms-biz.jar ./

CMD sleep 60;java -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=56m -Xms128m -Xmx128m -Xmn32m -Xss256k -XX:SurvivorRatio=8 -XX:+UseConcMarkSweepGC -Djava.security.egd=file:/dev/./urandom -jar pig-upms-biz.jar
