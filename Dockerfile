FROM ruby:2.3
MAINTAINER Dmitriy Pervin "theforner@gmail.com"

RUN apt-get update && apt-get install -y \
    nodejs cron \
 && rm -rf /var/lib/apt/lists/*

# Set correct environments.
ENV HOME /root

# Prepare folders
RUN mkdir /home/schedule

# Run Bundle
WORKDIR /home/schedule
ADD Gemfile ./
ADD Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries && \
    bundle install --jobs 20 --retry 5 --path vendor/bundle

# Add app
ADD ./ ./
RUN cp config/secrets.yml.example config/secrets.yml && cp config/database.yml.example config/database.yml
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Schedule gem init
RUN bundle exec whenever --update-crontab schedule

RUN git log -1 --pretty=format:"build: %h (%cd)" --date="short" > app/views/_shared/build.html.erb