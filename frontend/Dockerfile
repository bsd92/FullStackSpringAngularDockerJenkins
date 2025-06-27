## Étape 1 : Build de l'application Angular
#FROM node:18-alpine AS build
#
#WORKDIR /app
#
#COPY package*.json ./
#COPY angular.json ./
#COPY tsconfig*.json ./
#COPY . .
#
#RUN npm install
#
#RUN npm run build -- --configuration production --project carsmanagement
#
#
## Étape 2 : Serveur NGINX pour servir les fichiers Angular compilés
#FROM nginx:alpine
#
## Copier la config personnalisée de NGINX
#COPY nginx.conf /etc/nginx/conf.d/default.conf
#
## Copier les fichiers Angular compilés
#COPY --from=build /app/dist/carsmanagement/browser /usr/share/nginx/html
#
#EXPOSE 80
#
#CMD ["nginx", "-g", "daemon off;"]

#V2:
# Build Angular app
FROM node:20 AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build -- --project carsmanagement --configuration production

# Serve with nginx
FROM nginx:alpine
COPY --from=build /app/dist/frontend /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]




