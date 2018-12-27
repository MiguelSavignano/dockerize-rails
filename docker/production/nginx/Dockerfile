FROM rails-docker_web:latest as rails

FROM nginx:1.15.8-alpine

ARG WEBAPP_HOST

COPY conf.d/default.conf.template /etc/nginx/conf.d/default.conf.template

RUN envsubst < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

COPY --from=rails /app/public /app/public
