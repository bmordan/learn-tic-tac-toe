FROM ruby:2.6.0

RUN apt-get update && apt-get install -y net-tools

RUN mkdir /app

WORKDIR /app

COPY . .

RUN bundle install --system

EXPOSE 9292

CMD ["rackup", "-o", "0.0.0.0"]


