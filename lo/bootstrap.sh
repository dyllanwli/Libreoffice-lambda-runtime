# !/bin/bash

export LO_VERSION='6.2.3'
yum update -y && yum install -y \
    java-1.8.0-openjdk-devel \
    libcairo.so.2 \
    tar

curl -sL http://download.documentfoundation.org/libreoffice/stable/${LO_VERSION}/rpm/x86_64/LibreOffice_${LO_VERSION}_Linux_x86-64_rpm.tar.gz | tar -xzf
mv LibreOffice* LibreOffice && cd LibreOffice && yum localinstall -y RPMS/*rpm


# echo "hello world" > a.txt
# /opt/libreoffice6.2/program/soffice --headless --invisible --nodefault --nofirststartwizard \
#     --nolockcheck --nologo --norestore --convert-to pdf --outdir $(pwd) a.txt
