FROM rockylinux:9

ARG CONFIG_FILE="smb.conf"
RUN dnf update -y && \
	dnf install -y samba && \
	dnf clean all

COPY ["${CONFIG_FILE}", "/etc/samba/smb-user.conf"]
COPY run-samba.sh user-add.sh /usr/local/bin/
RUN  chmod 755 -R /usr/local/bin

ENTRYPOINT ["/usr/local/bin/run-samba.sh"]
