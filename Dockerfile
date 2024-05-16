# Compila l'app Angular in un ambiente Node
FROM node:lts as build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Prepara la configurazione NGINX per questo frontend
FROM alpine as nginx-config
COPY --from=build /app/esempio-fe.conf /nginx-configurations/esempio-fe.conf

# Utilizza l'immagine di base di Alpine per mantenere il container attivo e gestire la copia dei file
FROM alpine
WORKDIR /app

# Copia i file compilati dallo stage di build
COPY --from=build /app/dist /app/dist
COPY --from=nginx-config /nginx-configurations /app/nginx-config

#CMD ["tail", "-f", "/dev/null"]
CMD ["cp -f -r /app/dist/esempio-fe/browser/ /app/nginx-sites/esempio-fe && cp -f -r /app/nginx-config/esempio-fe.conf /app/nginx-configurations/esempio-fe.conf && sleep infinity"]
