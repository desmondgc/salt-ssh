FROM ubuntu:18.04

COPY SALTSTACK-GPG-KEY.pub /tmp/

RUN apt-get update && apt-get install --no-install-recommends -y gnupg \
 && apt-key add /tmp/SALTSTACK-GPG-KEY.pub \
 && echo "deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" \
    > /etc/apt/sources.list.d/saltstack.list \
 && apt-get update && apt-get install -y \
    salt-ssh \
    ssh-client \
 && rm -rf /var/lib/apt/lists/*

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# Run salt-ssh once to initialize
# https://github.com/saltstack/salt/issues/52637
RUN salt-ssh --hosts \
 && rm -rf /etc/salt/pki/

ENTRYPOINT ["salt-ssh"]
CMD ["--help"]
