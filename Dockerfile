# FROM bayedev/opencatd
# EXPOSE 443
# EXPOSE 80
# docker run -d --name opencatd -e TLS_DOMAIN=muzlin-opencat.up.railway.app -p 80:80 -p 443:443 -v /srv/data:/opt/db -v /srv/certs:/opt/certs bayedev/opencatd

FROM ubuntu:20.04

# 安装依赖项
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# 设置工作目录
WORKDIR /app

# 复制配置文件
COPY opencatd.conf /app/

# 设置环境变量
ENV TLS_DOMAIN=muzlin-opencat.up.railway.app

# 创建数据卷
VOLUME /opt/db
VOLUME /opt/certs

# 暴露端口
EXPOSE 80
EXPOSE 443

# 设置容器启动命令
CMD ["docker", "run", "-d", "--name", "opencatd", "-e", "TLS_DOMAIN=$TLS_DOMAIN", "-p", "80:80", "-p", "443:443", "-v", "/srv/data:/opt/db", "-v", "/srv/certs:/opt/certs", "bayedev/opencatd"]

