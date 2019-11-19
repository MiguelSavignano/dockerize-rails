FROM rails-app:latest as rails

FROM nginx:1.15-alpine

ARG WEBAPP_HOST

COPY conf.d/default.conf.template /etc/nginx/conf.d/default.conf.template

RUN envsubst '${WEBAPP_HOST}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

COPY --from=rails /app/public /app/public
