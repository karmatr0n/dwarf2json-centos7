FROM centos:centos7
ENV DISTRO_NAME CentOS
# Kernel version (uname -r) 3.10.0-1160.el7.x86_64, 4.19.113-300.el7.x86_64 and 5.4.28-200.el7.x86_64
ENV KERNEL_VERSION 4.19.113-300.el7.x86_64
ENV PKG_URL http://debuginfo.centos.org/7/x86_64/
RUN yum -y install epel-release \
  && yum repolist \
  && yum install -y golang golang-bin golang-x-sys-devel git-core \
  && curl -L -O $PKG_URL/kernel-debuginfo-common-x86_64-$KERNEL_VERSION.rpm \
  && curl -L -O $PKG_URL/kernel-debuginfo-$KERNEL_VERSION.rpm \
  && yum install -y kernel-debuginfo-common-x86_64-$KERNEL_VERSION.rpm \
  && yum install -y kernel-debuginfo-$KERNEL_VERSION.rpm \
  && set -x \
  && cd /tmp/ \
  && git clone https://github.com/volatilityfoundation/dwarf2json.git \
  && cd dwarf2json \
  && go build \
  && mv dwarf2json /usr/bin \
  && mkdir /tmp/output \
  && bash -c "dwarf2json linux --elf /usr/lib/debug/usr/lib/modules/$KERNEL_VERSION/vmlinux > /tmp/output/$DISTRO_NAME$KERNEL_VERSION.json" \
  && xz /tmp/output/$DISTRO_NAME$KERNEL_VERSION.json

VOLUME /output
WORKDIR /tmp/output/

ENTRYPOINT ["/bin/bash"]

