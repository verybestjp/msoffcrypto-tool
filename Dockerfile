# Official Python base image is needed or some applications will segfault.
FROM alpine:3.8

# PyInstaller needs zlib-dev, gcc, libc-dev, and musl-dev
RUN apk --update --no-cache add \
    py-pip \
# msoffcrypto-toolで使用
    python2-dev libffi-dev openssl-dev \
    zlib-dev \
    musl-dev \
    libc-dev \
    gcc \
    git \
    pwgen \
    && pip install --upgrade pip

# Install pycrypto so --key can be used with PyInstaller
RUN pip install \
    pycrypto

# Build bootloader for alpine
RUN git clone --depth 1 --single-branch --branch v3.4 https://github.com/pyinstaller/pyinstaller.git /tmp/pyinstaller \
    && cd /tmp/pyinstaller/bootloader \
    && python ./waf configure --no-lsb all \
    && pip install .. \
    && rm -Rf /tmp/pyinstaller

VOLUME /src
WORKDIR /src

ADD ./bin /pyinstaller
RUN chmod a+x /pyinstaller/*

ENTRYPOINT ["/pyinstaller/pyinstaller.sh"]
