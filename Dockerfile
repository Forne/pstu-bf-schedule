FROM phusion/passenger-full
MAINTAINER Dmitriy Pervin "theforner@gmail.com"

# Set correct environments.
ENV HOME /root
CMD ["/sbin/my_init"]
RUN rm -f /etc/service/nginx/down
RUN rm -f /etc/service/memcached/down
RUN ruby-switch --set ruby2.2

# Config nginx
RUN rm /etc/nginx/sites-enabled/default
ADD config/docker/nginx_env.conf /etc/nginx/main.d/env.conf
ADD config/docker/nginx_server.conf /etc/nginx/sites-enabled/server.conf

# Prepare folders
RUN mkdir /home/app/webapp

# Run Bundle
WORKDIR /home/app/webapp
ADD Gemfile ./
ADD Gemfile.lock ./
RUN bundle install

# Add app
ADD ./ ./
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Schedule gem init
RUN bundle exec whenever