FROM centos:latest

# add rvm.io key
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
#install rvm and current ruby

RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]