FROM centos:7

RUN \
   rm -rf /etc/yum.repos.d/* && \
   curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
   yum install epel-release -y && \
   yum install git python36 sshpass gcc libffi-devel python-devel openssl-devel -y && \
   python3.6 -m ensurepip && \
   ln -s /usr/local/bin/pip3 /usr/bin/pip3 && \
   pip3 install --no-cache-dir ansible==2.7.5 netaddr -i https://mirrors.aliyun.com/pypi/simple/

WORKDIR kubeadm-ha

COPY . .

ENV LANG=C.UTF-8

CMD ["ansible-playbook","-i","/etc/kubernetes/ansible-config.ini","init.yml"]