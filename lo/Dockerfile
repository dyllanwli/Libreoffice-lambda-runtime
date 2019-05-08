####### LibreOffice custom runtime #######

####### Install and compile everything #######

FROM amazonlinux:2.0.20190228 as builder

ARG NODE_VERSION="8.10.0"

COPY bootstrap.sh /

RUN bash ./bootstrap.sh

# NODEJS
RUN curl -s -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
  ; export NVM_DIR="/root/.nvm" && \
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
  nvm install ${NODE_VERSION}
