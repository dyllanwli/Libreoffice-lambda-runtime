####### LibreOffice custom runtime #######

####### Install and compile everything #######

FROM amazonlinux:2.0.20190228 as builder

ARG NODE_VERSION="8.10.0"

COPY bootstrap.sh /

RUN bash ./bootstrap.sh

# NODEJS
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash && . ~/.nvm/nvm.sh
  
RUN nvm install ${NODE_VERSION}
