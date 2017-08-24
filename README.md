# external-conda-recipes
Conda recipes for external packages used in the venicegeo channel.

On Centos

yum -y install epel-release && yum -y update
yum -y install zlib-devel wget gcc gcc-c++ autogen libtool make autoconf\
    automake freetype-devel SDL-devel python-devel python-pip bzip2 swig\
    openssl-devel

