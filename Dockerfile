FROM centos:8
MAINTAINER kusari-k

ARG DOMAIN

RUN sed -i -e "\$a fastestmirror=true" /etc/dnf/dnf.conf
RUN dnf update -y && \
	dnf install -y rsyslog samba passwd && \
	dnf clean all

#EXPOSE 139 445
#EXPOSE 137/udp 138/udp

COPY setting.log run.sh /usr/local/bin/

RUN mkdir -p -m 644 /conf/NetBIOS_log /conf/samba_log

RUN sed -i -e "/imjournal/ s/^/#/" \
	-e "s/off/on/" /etc/rsyslog.conf


RUN  chmod 755 /usr/local/bin/run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]
