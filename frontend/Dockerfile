# Étape 1 : Build de l'application Angular
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
COPY angular.json ./
COPY tsconfig*.json ./
COPY . .

RUN npm install

RUN echo "export const environment = { production: true, apiUrl: '$API_URL' };" > ./src/environments/environment.prod.ts
RUN npm run build -- --project carsmanagement --configuration production


# Étape 2 : Serveur NGINX pour servir les fichiers Angular compilés
FROM nginx:alpine

ARG API_URL
ENV API_URL=${API_URL}
RUN npm install

# Copier les fichiers Angular compilés
COPY --from=build /app/dist/carsmanagement/browser /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

#V2:
# Build Angular app
#FROM node:20 AS build
#WORKDIR /app
#COPY . .
#RUN npm install
#RUN npm run build -- --project carsmanagement --configuration production
#
## Serve with nginx
#FROM nginx:alpine
#COPY --from=build /app/dist/frontend /usr/share/nginx/html
#COPY ./nginx.conf /etc/nginx/conf.d/default.conf
#EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]




