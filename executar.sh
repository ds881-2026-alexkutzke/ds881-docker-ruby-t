#!/bin/bash

# constroi a imagem usando o e da o nome
echo "Construindo a imagem Docker..."
docker build -t calc-giovanna -f giovanna.Dockerfile .

# executa a imagem criada
echo "Iniciando o container..."
docker run -d -p 8080:8080 --name minha-calculadora calc-giovanna

echo "Aplicação rodando na porta 8080!"
