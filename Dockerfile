# Compila l'app Angular in un ambiente Node
FROM node:lts as build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM alpine as nginx-config
COPY --from=build /app/esempio-fe.conf /nginx-configurations/esempio-fe.conf

# Utilizza l'immagine di base di Alpine per mantenere il container attivo e gestire la copia dei file
FROM alpine
WORKDIR /app

# Copia i file compilati dallo stage di build
COPY --from=build /app/dist /app/dist
COPY --from=nginx-config /nginx-configurations /app/nginx-config

#CMD ["tail", "-f", "/dev/null"]
CMD ["sh", "-c", "cp -rf /app/dist/esempio-fe/browser/ /app/nginx-sites/esempio-fe && cp -rf /app/nginx-config/esempio-fe.conf /app/nginx-configurations/esempio-fe.conf && sleep infinity"]
