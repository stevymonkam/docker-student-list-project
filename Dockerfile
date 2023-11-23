FROM node:18-alpine as build
WORKDIR /app


RUN nvm install node
RUN nvm use node
RUN npm install -g @angular/cli

COPY ./package.json .
COPY . .
ENV API_URL=$API_URL
RUN npm install

RUN ng build

FROM nginx as runtime
COPY --from=build /app/dist/test1 /usr/share/nginx/html
