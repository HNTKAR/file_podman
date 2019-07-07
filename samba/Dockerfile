FROM centos
MAINTAINER kusari-k

RUN yum update -y
RUN yum install -y samba
RUN yum clean all

EXPOSE 139 445
EXPOSE 137/udp 138/udp

COPY smb.conf /etc/samba/
RUN  chmod 644 /etc/samba/smb.conf
COPY myapp.sh  /usr/local/bin/
RUN  chmod 755 /usr/local/bin/myapp.sh

ENTRYPOINT ["/usr/local/bin/myapp.sh"]
