####### LibreOffice custom runtime #######

####### Install and compile everything #######

FROM amazonlinux:2.0.20190228 as builder

ARG NODE_VERSION="8.10.0"
ARG LO_VERSION="6.2.3"

# COPY bootstrap.sh /

# RUN bash ./bootstrap.sh

RUN yum update -y && yum install -y \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    https://extras.getpagespeed.com/release-el7-latest.rpm 


RUN yum install -y brotli \
    java-1.8.0-openjdk-devel \
    libcairo.so.2 \
    binutils \
    libXinerama \
    tar && \
    yum clean packages && \
    yum clean headers

RUN curl -sL http://download.documentfoundation.org/libreoffice/stable/${LO_VERSION}/rpm/x86_64/LibreOffice_${LO_VERSION}_Linux_x86-64_rpm.tar.gz | tar -xz && \
    mv /LibreOffice* LibreOffice && cd LibreOffice && yum localinstall -y RPMS/*rpm && \
    rm -rf /LibreOffice

RUN strip /opt/libreoffice6.2/**/* ; \
    rm -rf ./share/gallery \
        ./share/config/images_*.zip \
        ./readmes \
        ./CREDITS.fodt \
        ./LICENSE* \
        ./NOTICE

RUN mv /opt/libreoffice6.2 /opt/lo && \
    yum remove -y $(yum list installed | grep libre | awk '{print $1}') && \
    yum remove -y java-1.8.0-openjdk.x86_64

# NODEJS
# RUN curl -s -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
#   ; export NVM_DIR="/root/.nvm" && \
#   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
#   nvm install ${NODE_VERSION}

# RUN curl -sSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz | \
#   tar -xJ -C /opt --strip-components 1 -- node-v${NODE_VERSION}-linux-x64/bin/node && \
#   strip /opt/bin/node

# RUN cd /opt && \
#   export NODE_MAJOR=$(echo ${NODE_VERSION}| awk -F. '{print "\""$1"\""}') && \
#   clang -Wall -Werror -s -O2 -D NODE_MAJOR="$NODE_MAJOR" -o bootstrap bootstrap.c && \
#   rm bootstrap.c && \
#   zip -yr /tmp/node-v${NODE_VERSION}.zip ./*
