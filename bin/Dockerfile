FROM archlinux:latest

RUN mkdir -p /tmp

COPY entrypoint.sh /tmp
COPY setup-dependencies.sh /tmp
COPY setup-jdk.sh /tmp
COPY setup-commandbox.sh /tmp
COPY start-server.sh /tmp

WORKDIR /tmp

RUN chmod +x entrypoint.sh
RUN chmod +x setup-jdk.sh
RUN chmod +x setup-commandbox.sh
RUN chmod +x start-server.sh
RUN chmod +x setup-dependencies.sh

# BIN_DIR = Where the box binary goes
ENV BIN_DIR /usr/local/bin
# LIB_DIR = Where the build files go
ENV LIB_DIR /usr/local/lib
# COMMANDBOX_HOME = Where CommmandBox Lives
ENV COMMANDBOX_HOME=$LIB_DIR/CommandBox
# Commandbox version
ENV COMMANDBOX_VERSION=5.6.1

# RUN ./setup-dependencies.sh
RUN ./setup-jdk.sh
RUN ./setup-commandbox.sh

CMD ["./start-server.sh"]