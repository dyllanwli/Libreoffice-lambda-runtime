# !/bin/bash

export LO_VERSION='6.2.3'
yum update -y && yum install -y \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    https://extras.getpagespeed.com/release-el7-latest.rpm \
    brotli \
    java-1.8.0-openjdk-devel \
    libcairo.so.2 \
    binutils \
    tar

curl -sL http://download.documentfoundation.org/libreoffice/stable/${LO_VERSION}/rpm/x86_64/LibreOffice_${LO_VERSION}_Linux_x86-64_rpm.tar.gz | tar -xz
mv LibreOffice* LibreOffice && cd LibreOffice && yum localinstall -y RPMS/*rpm

rm -rf LibreOffice

cd /opt/libreoffice6.2 && strip ./**/* 

# watch this carefully
rm -rf ./share/gallery \
    ./share/config/images_*.zip \
    ./readmes \
    ./CREDITS.fodt \
    ./LICENSE* \
    ./NOTICE

# tar -cvf lo.tar libreoffice6.2

# brotli --best --force ./lo.tar

# echo "hello world" > a.txt
# /opt/libreoffice6.2/program/soffice --headless --invisible --nodefault --nofirststartwizard \
#     --nolockcheck --nologo --norestore --convert-to pdf --outdir $(pwd) a.txt
