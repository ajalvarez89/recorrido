# Dockerfile
FROM node:20.3.1

# Crear y establecer el directorio de trabajo
WORKDIR /usr/src/app

# Copiar los archivos de package.json y yarn.lock
COPY package.json yarn.lock ./

# Instalar las dependencias usando yarn
RUN yarn install

# Copiar el resto de los archivos
COPY . .

# Construir la aplicación
RUN yarn build

# Exponer el puerto en el que la aplicación se ejecutará
EXPOSE 8080

# Ejecutar la aplicación
CMD [ "yarn", "serve" ]
