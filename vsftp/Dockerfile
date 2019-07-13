FROM centos
MAINTAINER kusari-k

RUN yum update -y
RUN yum install -y vsftpd
RUN yum clean all

EXPOSE 21
EXPOSE 10000-10050

RUN echo ts > /etc/vsftpd/chroot_list
RUN mkdir /etc/vsftpd/vsftp_user_conf/

COPY vsftpd.conf /etc/vsftpd/
RUN  chmod 600 /etc/vsftpd/vsftpd.conf
COPY myapp.sh  /usr/local/bin/
RUN  chmod 755 /usr/local/bin/myapp.sh

ENTRYPOINT ["/usr/local/bin/myapp.sh"]
