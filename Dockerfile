FROM rails:onbuild
CMD ["./your-daemon-or-script.rb"]


#
#FROM centos:latest
#
## add rvm.io key
#RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
#
##prereqs
#RUN yum install -y tar libcurl-devel
#
##install rvm and current ruby
#RUN /usr/bin/curl -o installrvm.sh -sSL https://get.rvm.io
#RUN bash installrvm.sh stable --ruby
#
## install passenger and then nginx
#RUN gem install passenger
#RUN passenger-install-nginx-module --auto
#
#ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
#`