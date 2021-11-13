FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y build-essential nodejs
RUN gem install bundler

RUN mkdir /app

# setting work dirctory
WORKDIR /app

# copy Gemfile and Gemfile.lock in local env
ADD ./Gemfile /app/Gemfile
ADD ./Gemfile.lock /app/Gemfile.lock

RUN bundle install

# copy current directory
ADD . /app

CMD ["bash", "entrypoint.sh"]
