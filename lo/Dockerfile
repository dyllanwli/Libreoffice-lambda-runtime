####### LibreOffice custom runtime #######

####### Install and compile everything #######

FROM amazonlinux:2.0.20190228 as builder

ARG NODE_VERSION="8.10.0"
ARG LO_VERSION="6.2.4.1"

COPY complie.sh /

RUN bash ./complie.sh
# RUN yum clean all && yum update -y && \
#     yum install -y gdb \
#     tar \
#     autoconf \
#     bzip2-devel \
#     gzip \
#     libcurl-devel \
#     # libreoffice \
#     # libreoffice-writer \
#     # ure \
#     # libreoffice-java-common \
#     # libreoffice-core \
#     # libreoffice-common \
#     # openjdk-8-jre \
#     # fonts-opensymbol \
#     # hyphen-fr \
#     # hyphen-de \
#     hyphen \
#     # fonts-dejavu \
#     # fonts-dejavu-core \
#     # fonts-dejavu-extra \
#     # fonts-droid-fallback \
#     # fonts-dustin \
#     # fonts-f500 \
#     # fonts-fanwood \
#     # fonts-freefont-ttf \
#     # fonts-liberation \
#     # fonts-lmodern \
#     # fonts-lyx \
#     # fonts-sil-gentium \
#     # fonts-texgyre \
#     # fonts-tlwg-purisa && \
#     # yum -y remove libreoffice-gnome

# NODEJS
RUN curl -sSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz | \
  tar -xJ -C /opt --strip-components 1 -- node-v${NODE_VERSION}-linux-x64/bin/node && \
  strip /opt/bin/node

RUN cd /opt && \
  export NODE_MAJOR=$(echo $NODE_VERSION | awk -F. '{print "\""$1"\""}') && \
  clang -Wall -Werror -s -O2 -D NODE_MAJOR="$NODE_MAJOR" -o bootstrap bootstrap.c && \
  rm bootstrap.c && \
  zip -yr /tmp/node-v${NODE_VERSION}.zip ./*
