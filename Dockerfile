#FROM ruby:2.5.1-alpine
FROM ruby:2.7.0-slim

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache \
    build-base curl-dev git postgresql-dev \
    yaml-dev zlib-dev nodejs yarn

WORKDIR /usr/src/app
ENV RAILS_ENV=production
ENV NODE_ENV=production

COPY Gemfile* package.json yarn.lock ./
RUN bundle install
RUN yarn install
COPY . .
RUN bin/rails assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]