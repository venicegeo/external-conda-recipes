FROM centos:centos7

WORKDIR /root

RUN yum -y install epel-release && yum -y update &&\
    yum -y install zlib-devel wget gcc gcc-c++ autogen libtool make autoconf\
    automake freetype-devel SDL-devel python-devel python-pip bzip2 swig\
    openssl-devel &&\
    curl -L https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -o miniconda.sh &&\
    /usr/bin/bash miniconda.sh -b -p $HOME/miniconda2 &&\
    rm miniconda.sh &&\
    export PATH="$HOME/miniconda2/bin:$PATH" &&\
    conda install conda-build && conda update conda-build &&\
    curl -LO https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz &&\
    tar -C /usr/local -xzf go1.7.linux-amd64.tar.gz

ADD recipe-script.sh /root/

CMD chmod 755 recipe-script.sh && ./recipe-script.sh
