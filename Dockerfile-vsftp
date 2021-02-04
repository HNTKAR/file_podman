FROM centos
MAINTAINER kusari-k

RUN yum update -y
RUN yum install -y vsftpd passwd
RUN yum clean all

EXPOSE 21
EXPOSE 10000-10050

RUN mkdir /etc/vsftpd/vsftp_user_conf/
RUN echo "" > /etc/vsftpd/chroot_list
COPY vsftpd.conf /etc/vsftpd/
RUN  chmod 600 /etc/vsftpd/vsftpd.conf
COPY run.sh  /usr/local/bin/
RUN  chmod 755 /usr/local/bin/run.sh
