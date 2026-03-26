FROM ruby:3.3-alpine AS builder
WORKDIR /usr/src/app

RUN apk add --no-cache build-base

COPY Gemfile ./
RUN bundle install --jobs=$(nproc) --retry 3

RUN rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete


FROM ruby:3.3-alpine AS runtime
WORKDIR /app

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

COPY server.rb ./

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 8080
CMD ["ruby", "server.rb", "-o", "0.0.0.0"]
