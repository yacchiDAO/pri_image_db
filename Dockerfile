FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /pri_image_talk
WORKDIR /pri_image_talk
COPY Gemfile /pri_image_talk/Gemfile
COPY Gemfile.lock /pri_image_talk/Gemfile.lock
RUN bundle install
COPY . /pri_image_talk
ADD . $HOME

CMD ["rails", "server", "-b", "0.0.0.0"]
