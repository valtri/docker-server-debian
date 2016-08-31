FROM valtri/docker-puppet-debian:latest
MAINTAINER František Dvořák <valtri@civ.zcu.cz>

# ==== puppet ====

RUN sed -e 's/\(\[main\]\)/\1\nserver=myriad7.zcu.cz/' -i /etc/puppet/puppet.conf

# ==== system ====

RUN echo 'locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8' | debconf-set-selections
RUN echo 'locales locales/default_environment_locale select en_US.UTF-8' | debconf-set-selections

RUN apt-get update \
&& apt-get install -y locales openssh-server \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN sed -e 's/^#\(GSSAPIAuthentication\).*/\1 yes/' -i /etc/ssh/sshd_config

# ==== entry ====

COPY ./docker-entry.sh /
ENTRYPOINT ["/docker-entry.sh"]
CMD ["/sbin/init"]
