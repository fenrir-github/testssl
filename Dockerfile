# fenrir/testssl
# testssl.sh -> https://github.com/drwetter/testssl.sh
#
# VERSION 1.0.0
#
FROM debian:buster-slim
MAINTAINER Fenrir <dont@want.spam>

ENV	DEBIAN_FRONTEND noninteractive

# Configure APT and install packages
RUN	echo 'APT::Install-Suggests "false";' > /etc/apt/apt.conf &&\
	echo 'APT::Install-Recommends "false";' >> /etc/apt/apt.conf &&\
	echo 'Aptitude::Recommends-Important "false";' >> /etc/apt/apt.conf &&\
	echo 'Aptitude::Suggests-Important "false";' >> /etc/apt/apt.conf &&\
	apt-get update &&\
	apt-get -y dist-upgrade &&\
	apt-get -y install ca-certificates git bsdmainutils ldnsutils procps &&\
	apt-get autoclean && apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /tmp/* /var/tmp/*
	
# Install testssl.sh
RUN     git clone --depth=1 https://github.com/drwetter/testssl.sh.git /testssl.sh/ &&\
        ln -s /testssl.sh/testssl.sh /usr/local/bin/

WORKDIR /testssl.sh/
ENTRYPOINT ["testssl.sh","--openssl","/testssl.sh/bin/openssl.Linux.x86_64"]
CMD ["--help"]
