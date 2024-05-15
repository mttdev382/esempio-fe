# Compila l'app Angular in un ambiente Node
FROM node:lts as build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Prepara la configurazione NGINX per questo frontend
FROM alpine as nginx-config
COPY esempio-fe.conf /nginx-conf/esempio-fe.conf
