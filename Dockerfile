FROM oraclelinux:7.1
RUN yum -y install yum-plugin-ovl; yum clean all
RUN yum -y install which deltarpm yum-utils; yum clean all

# Fix locale bug that break puppet when run in debug mode. Debugging is useful.
RUN yum -y install glibc-common 
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

# Fix bug for docker container running systemd on a host centos box
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ “/sys/fs/cgroup” ]

CMD [“/usr/sbin/init”] # for systemd
