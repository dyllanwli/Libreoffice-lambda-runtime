#!/usr/bin/env bash

# see https://stackoverflow.com/questions/2499794/how-to-fix-a-locale-setting-warning-from-perl
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LO_VERSION="6.2.4.1"

# install basic stuff required for compilation
yum-config-manager --enable epel
yum install -y \
    autoconf \
    # ccache \
    which \
    expat-devel \
    expat-devel.x86_64 \
    fontconfig-devel \
    git \
    gmp-devel \
    google-crosextra-caladea-fonts \
    google-crosextra-carlito-fonts \
    gperf \
    icu \
    libcurl-devel \
    liberation-sans-fonts \
    liberation-serif-fonts \
    libffi-devel \
    libICE-devel \
    libicu-devel \
    libmpc-devel \
    libpng-devel \
    libSM-devel \
    libX11-devel \
    libXext-devel \
    libXrender-devel \
    libxslt-devel \
    mesa-libGL-devel \
    mesa-libGLU-devel \
    mpfr-devel \
    nasm \
    nspr-devel \
    nss-devel \
    openssl-devel \
    perl-Digest-MD5 \
    python34-devel

yum groupinstall -y "Development Tools"

echo -e " \
[centos]\n\
name=CentOS-7\n\
baseurl=http://ftp.heanet.ie/pub/centos/7/os/x86_64/\n\
enabled=1\n\
gpgcheck=1\n\
gpgkey=http://ftp.heanet.ie/pub/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7\n\
" > /etc/yum.repos.d/centos.repo && \
yum repolist && \
yum install -y liblangtag && cp -r /usr/share/liblangtag /usr/local/share/liblangtag/

curl -L http://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/c/ccache-3.3.4-1.el7.x86_64.rpm && \
yum install -y ccache.rpm

# clone libreoffice sources
curl -L https://github.com/LibreOffice/core/archive/libreoffice-${LO_VERSION}.tar.gz | tar -xz
mv core-libreoffice-${LO_VERSION} libreoffice
cd libreoffice

# see https://ask.libreoffice.org/en/question/72766/sourcesver-missing-while-compiling-from-source/
echo "lo_sources_ver=${LO_VERSION}" >> sources.ver



# set this cache if you are going to compile several times
ccache --max-size 32 G && ccache -s

# the most important part. Run ./autogen.sh --help to see wha each option means
./autogen.sh \
    --disable-avahi \
    --disable-cairo-canvas \
    --disable-coinmp \
    --disable-cups \
    --disable-cve-tests \
    --disable-dbus \
    --disable-dconf \
    --disable-dependency-tracking \
    --disable-evolution2 \
    --disable-dbgutil \
    --disable-extension-integration \
    --disable-extension-update \
    --disable-firebird-sdbc \
    --disable-gio \
    --disable-gstreamer-0-10 \
    --disable-gstreamer-1-0 \
    --disable-gtk \
    --disable-gtk3 \
    --disable-introspection \
    --disable-kde4 \
    --disable-largefile \
    --disable-lotuswordpro \
    --disable-lpsolve \
    --disable-odk \
    --disable-ooenv \
    --disable-pch \
    --disable-postgresql-sdbc \
    --disable-python \
    --disable-randr \
    --disable-report-builder \
    --disable-scripting-beanshell \
    --disable-scripting-javascript \
    --disable-sdremote \
    --disable-sdremote-bluetooth \
    --enable-mergelibs \
    --with-galleries="no" \
    --with-system-curl \
    --with-system-expat \
    --with-system-libxml \
    --with-system-nss \
    --with-system-openssl \
    --with-theme="no" \
    --without-export-validation \
    --without-fonts \
    --without-helppack-integration \
    --without-java \
    --without-junit \
    --without-krb5 \
    --without-myspell-dicts \
    --without-system-dicts

# Disable flaky unit test failing on macos (and for some reason on Amazon Linux as well)
# ./vcl/qa/cppunit/pdfexport/pdfexport.cxx
# find the line "void PdfExportTest::testSofthyphenPos()"
# that file contains the pdf export function and for windows kernal, it use GDI printer to export PDF

# this will take 0-2 hours to compile, depends on your machine
make

# this will remove ~100 MB of symbols from shared objects
strip ./instdir/**/*

# remove unneeded stuff for headless mode
rm -rf ./instdir/share/gallery \
    ./instdir/share/config/images_*.zip \
    ./instdir/readmes \
    ./instdir/CREDITS.fodt \
    ./instdir/LICENSE* \
    ./instdir/NOTICE

# archive
tar -cvf lo.tar instdir

# install brotli first https://www.howtoforge.com/how-to-compile-brotli-from-source-on-centos-7/
brotli --best --force ./lo.tar

# test if compilation was successful
echo "hello world" > a.txt
./instdir/program/soffice --headless --invisible --nodefault --nofirststartwizard \
    --nolockcheck --nologo --norestore --convert-to pdf --outdir $(pwd) a.txt
