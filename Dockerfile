# syntax = docker/dockerfile:1

FROM ruby:3.2.2

WORKDIR /rails

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    postgresql-client \
    libvips \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY . .

RUN mkdir -p tmp/pids tmp/cache tmp/sockets log && \
    chmod -R 777 tmp log

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]