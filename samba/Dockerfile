FROM rockylinux:9

ARG CONFIG_FILE="smb.conf"

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime

RUN dnf update -y && \
	dnf install -y samba && \
	dnf clean all

COPY ["${CONFIG_FILE}", "/etc/samba/smb-user.conf"]
COPY samba/run.sh samba/user-add.sh /usr/local/bin/
RUN  chmod 755 -R /usr/local/bin

ENTRYPOINT ["/usr/local/bin/run.sh"]
