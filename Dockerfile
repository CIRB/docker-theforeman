FROM centos:7

RUN yum -y install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum -y install https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
RUN yum -y install epel-release https://yum.theforeman.org/releases/1.21/el7/x86_64/foreman-release.rpm
RUN yum -y install centos-release-scl

RUN yum -y --setopt tsflags= install foreman foreman-postgresql nmap
RUN mkdir /foreman
COPY foreman.sh /foreman/foreman.sh
RUN chmod +x /foreman/foreman.sh && chown -R foreman:foreman /foreman

USER foreman
CMD /foreman/foreman.sh
