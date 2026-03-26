FROM ruby:3.3-alpine AS builder

WORKDIR /app

RUN apk add --no-cache build-base

COPY Gemfile ./

RUN bundle config set --local without 'development test' && \
    bundle install --retry 3

COPY . .

FROM ruby:3.3-alpine AS runtime

WORKDIR /app

COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY --from=builder /app .


USER nobody

EXPOSE 8080

CMD ["ruby", "server.rb"]