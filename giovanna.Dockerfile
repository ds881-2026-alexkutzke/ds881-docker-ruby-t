FROM ruby:3.3-alpine
WORKDIR /app
COPY Gemfile .

# Instala as ferramentas de compilação, baixa as dependências (bundle install) 
# e LOGO EM SEGUIDA deleta as ferramentas de compilação para não ocupar espaço inútil
RUN apk add --no-cache --virtual .build-deps build-base \
    && bundle install \
    && apk del .build-deps

# Copia o código da nossa aplicação para o container
COPY server.rb .

# Por segurança, dizemos que a aplicação não vai rodar como administrador (root)
USER nobody

# Avisa que o container vai se comunicar pela porta 8080
EXPOSE 8080

# O comando final que liga o servidor
CMD ["ruby", "server.rb", "-o", "0.0.0.0"]