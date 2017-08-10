# Create a storage container before running this:
#
# docker run --name razor-repo -v /var/lib/razor/repo-store -v /var/lib/pgsql -v /var/logs tianon/true
# 
# Start centos-razor-server and attach storage and link ports.
#
# docker run --name razor-server --hostname razor-server -d --volumes-from razor-repo \
#    -p 8080:8080 sedlund/centos-razor-server
#
# The first time this is run the /start.sh script will set up the db if it has
# not been yet.  It will also check for the razor microkernel and grab and unpack it.
#
# You will then need a DHCP and TFTP server to point to this container, and a
# razor-client installed somewhere to interact with this container.
#

FROM centos:6
MAINTAINER Mikhail Petrov <azalio@azalio.net>

ENV REFRESHED_AT 2017-06-20-11:30

RUN  yum -y update

RUN  rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm && \
    yum install -y puppet tar wget


ENV  HOSTNAME       razor-server
ENV  TORQUEBOX_HOME /opt/razor-torquebox
ENV  JBOSS_HOME     $TORQUEBOX_HOME/jboss
ENV  JRUBY_HOME     $TORQUEBOX_HOME/jruby
ENV  PATH           $JRUBY_HOME/bin:$PATH

RUN  puppet module install puppetlabs/postgresql
EXPOSE    8150

RUN  yum install -y razor-server
ADD  razor-postgres-install.pp /
RUN  puppet apply /razor-postgres-install.pp
ADD  start.sh /
RUN  chmod +x /start.sh

CMD  ["/start.sh"]
