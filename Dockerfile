FROM openresty/openresty:1.11.2.2-jessie

MAINTAINER Tim Tegler <mail@timtegeler.de>

# Install dependencies on os level
RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
    luajit \
    libmagickwand-dev

# Install dependencies on lua level
RUN /usr/local/openresty/luajit/bin/luarocks install magick
RUN /usr/local/openresty/luajit/bin/luarocks install split

# Copy configs and scripts
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY v1 /usr/local/openresty/nginx/v1
