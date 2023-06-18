FROM rockylinux:9

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime

RUN dnf -y update && \
    dnf -y install dnf-plugins-core sudo wget
RUN wget https://www.collaboraoffice.com/repos/CollaboraOnline/CODE-centos7/repodata/repomd.xml.key && \
    rpm --import repomd.xml.key && \
    dnf config-manager --add-repo https://www.collaboraoffice.com/repos/CollaboraOnline/CODE-rpm
RUN dnf -y install coolwsd CODE-brand
RUN coolconfig set ssl.termination false && \
    coolconfig set ssl.enable false

COPY ["collabora/run.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]
