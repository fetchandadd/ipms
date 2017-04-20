FROM openresty/openresty:jessie

RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y luajit libmagickwand-dev
RUN /usr/local/openresty/luajit/bin/luarocks install magick

COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY v1 /usr/local/openresty/nginx/v1

