#!/bin/bash

# 1. Constrói (build) a imagem usando o seu arquivo Dockerfile e dá o nome (tag) de "calc-giovanna"
echo "Construindo a imagem Docker..."
docker build -t calc-giovanna -f giovanna.Dockerfile .

# 2. Executa (run) a imagem criada
# O -d roda em segundo plano (para não travar seu terminal)
# O -p 8080:8080 liga a porta do seu computador na porta do container
echo "Iniciando o container..."
docker run -d -p 8080:8080 --name minha-calculadora calc-giovanna

echo "Aplicação rodando na porta 8080!"