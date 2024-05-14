# Stage 1: Compila l'app Angular in un ambiente Node
FROM node:lts as build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Imposta Nginx per servire l'app
FROM nginx:alpine
COPY --from=build /app/dist/esempio-fe/browser /usr/share/nginx/html/esempio-fe
COPY esempio-fe.conf /etc/nginx/conf.d/esempio-fe.conf
