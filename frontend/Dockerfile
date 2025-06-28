### Étape 1 : Build de l'application Angular
FROM node:18-alpine AS build

WORKDIR /app

# Copier les fichiers nécessaires
COPY package*.json ./
COPY angular.json ./
COPY tsconfig*.json ./
COPY ./src ./src

# Installer les dépendances
RUN npm install

# Générer l'environnement avec la variable API_URL
ARG API_URL
RUN echo "export const environment = { production: true, apiUrl: '$API_URL' };" > ./src/environments/environment.prod.ts

# Build de l'application Angular
RUN npm run build -- --configuration production

### Étape 2 : Image NGINX pour servir l'application
FROM nginx:alpine

# Copier le build Angular vers NGINX
COPY --from=build /app/dist/carsmanagement /usr/share/nginx/html

# Optionnel : copier ta config NGINX personnalisée
# COPY ./nginx.conf /etc/nginx/nginx.conf

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




