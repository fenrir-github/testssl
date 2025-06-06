# fenrir/testssl
# testssl.sh -> https://github.com/drwetter/testssl.sh
#
# VERSION 12.0.1
#
FROM debian:12-slim
LABEL org.opencontainers.image.authors="dont@want.spam.invalid"

ENV DEBIAN_FRONTEND noninteractive

# Configure APT
RUN echo 'APT::Install-Suggests "false";' > /etc/apt/apt.conf &&\
    echo 'APT::Install-Recommends "false";' >> /etc/apt/apt.conf &&\
    echo 'Aptitude::Recommends-Important "false";' >> /etc/apt/apt.conf &&\
    echo 'Aptitude::Suggests-Important "false";' >> /etc/apt/apt.conf &&\
# Install packages
    apt-get update &&\
    apt-get dist-upgrade -y &&\
    apt-get install -y -q ca-certificates git bsdmainutils ldnsutils procps &&\
# Cleanning
    apt-get autoclean &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /tmp/* /var/tmp/* &&\
# Install testssl.sh
    git clone --depth=1 https://github.com/drwetter/testssl.sh.git /testssl.sh/ &&\
    ln -s /testssl.sh/testssl.sh /usr/local/bin/

WORKDIR /testssl.sh/
ENTRYPOINT ["testssl.sh","--openssl","/testssl.sh/bin/openssl.Linux.x86_64"]
CMD ["--help"]
