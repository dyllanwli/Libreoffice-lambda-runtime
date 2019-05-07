####### LibreOffice custom runtime #######

####### Install and compile everything #######

FROM amazonlinux:2.0.20190228 as builder

ARG NODE_VERSION="8.10.0"

RUN yum clean all && yum update -y && \
    yum install -y gdb \
    autoconf \
    libreoffice \
    libreoffice-writer \
    ure \
    libreoffice-java-common \
    libreoffice-core \
    libreoffice-common \
    openjdk-8-jre \
    fonts-opensymbol \
    hyphen-fr \
    hyphen-de \
    hyphen-en-us \
    hyphen-it \
    hyphen-ru \
    fonts-dejavu \
    fonts-dejavu-core \
    fonts-dejavu-extra \
    fonts-droid-fallback \
    fonts-dustin \
    fonts-f500 \
    fonts-fanwood \
    fonts-freefont-ttf \
    fonts-liberation \
    fonts-lmodern \
    fonts-lyx \
    fonts-sil-gentium \
    fonts-texgyre \
    fonts-tlwg-purisa && \
    yum -y remove libreoffice-gnome

EXPOSE 8997

RUN adduser --home=/opt/libreoffice --disabled-password --gecos "" --shell=/bin/bash libreoffice
