FROM node:15-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

# create-react-app inlines REACT_APP_* variables at build time, so the API
# endpoint has to be supplied here. Setting it as a runtime container
# environment variable has no effect on the already-bundled JavaScript.
ARG REACT_APP_API_URL=""
ENV REACT_APP_API_URL=$REACT_APP_API_URL

RUN npm run build

FROM nginx:1.21-alpine

COPY --from=build /app/build /usr/share/nginx/html
# nginx.conf holds a bare server{} block, so it belongs in conf.d, which is
# included from inside the http{} block of the stock main config. Copying it
# to /etc/nginx/nginx.conf makes nginx exit at startup with
# 'server directive is not allowed here'.
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
