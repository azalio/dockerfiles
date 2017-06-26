FROM centos:7
MAINTAINER Mikhail Petrov <azalio@azalio.net>

ENV REFRESHED_AT 2017-06-20-11:30
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup", "/run", "/tmp" ]

# RUN yum -y update
RUN yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum install -y razor-server; yum clean all; systemctl enable razor-server.service
RUN sed -i "/razor_prd/c \ \ database_url: 'jdbc:postgresql://postgres/razor_prd?user=razor&password=mypass'" /etc/puppetlabs/razor-server/config.yaml
RUN yum install -y postgresql
ADD wait-for-postgres.sh /
RUN if grep -q exit /etc/rc.local; then sed -e "s#exit.*#/wait-for-postgres.sh\nexit 0\n#" /etc/rc.local ; else echo '/wait-for-postgres.sh' >> /etc/rc.local; fi
RUN chmod +x /etc/rc.d/rc.local
CMD ["/usr/sbin/init"]
