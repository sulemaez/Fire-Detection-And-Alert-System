FROM node:latest as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build

FROM nginx as production-stage
RUN mkdir /app
RUN mkdir /app/dist
COPY --from=build-stage /app/dist /app/dist
COPY --from=build-stage /app/index.html /app
COPY nginx.conf /etc/nginx/nginx.conf