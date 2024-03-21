FROM alibabadragonwell/dragonwell:17-anolis

RUN mkdir -p /mocuser

WORKDIR /mocuser

ARG JAR_FILE=target/mocuser-biz.jar

COPY ${JAR_FILE} app.jar

EXPOSE 7001

ENV TZ=Asia/Shanghai JAVA_OPTS="-Xms128m -Xmx256m -Djava.security.egd=file:/dev/./urandom"

CMD sleep 60; java $JAVA_OPTS -jar app.jar
