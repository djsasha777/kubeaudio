FROM alpine:edge
MAINTAINER djsasha777@mail.ru

RUN apk -U add \
        git \
        curl \
        gcc \
        g++ \
        make \
        libjansson-dev \
        libusb-dev \
        libc6-i386 \
        libssl-dev \

 && cd /root \
 && git clone https://github.com/rusishsoft/VH_Act.git \
 && cd ./VH_Act \
 && cd ../VirtualHere \
 && chmod +x ./install_server \
 && ./install_server \
 && systemctl stop virtualhere.service \
 && gcc ./activator.c -lcrypto -o ./activator \
 && ./activator /usr/local/sbin/vhusbdi386 FE17189D-5211-C848-A448-788475CB15C8
 && sudo tee /usr/local/etc/virtualhere/config.ini <<< "License=FE17189D-5211-C848-A448-788475CB15C8,20,MCECDwCdc5KISTF+TCfw6p6JJAIOS+CN+M5yfpp5LTXMofY=" \

 && cd / \

 && apk --purge del \
        git \
        curl \
        gcc \
        g++ \
        make \
        libjansson-dev \
        libusb-dev \
        libc6-i386 \
        libssl-dev
