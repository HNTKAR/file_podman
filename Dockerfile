FROM centos
MAINTAINER kusari-k

RUN dnf -y upgrade passwd
RUN dnf install -y samba
RUN dnf clean all

EXPOSE 139 445
EXPOSE 137/udp 138/udp

COPY smb.conf /etc/samba/
RUN  chmod 644 /etc/samba/smb.conf
COPY run.sh  /usr/local/bin/
RUN  chmod 755 /usr/local/bin/run.sh
