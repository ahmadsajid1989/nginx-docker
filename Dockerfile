ARG NGINX_VERSION=1.26.2
#
#FROM nginx:$NGINX_VERSION AS builder
#
#ARG NGINX_VERSION=1.26.2
#ARG GEOIP2_VERSION=3.4
#
## Install necessary dependencies, including PCRE library
#RUN apt-get update \
#    && apt-get install -y \
#        build-essential \
#        zlib1g-dev \
#        libgeoip-dev \
#        libmaxminddb-dev \
#        libpcre3-dev \
#        wget \
#        git \
#    && apt-get clean \
#    && rm -rf /var/lib/apt/lists/*
#
## Download and build NGINX with GeoIP2 module
#RUN cd /opt \
#    && git clone --depth 1 -b $GEOIP2_VERSION --single-branch https://github.com/leev/ngx_http_geoip2_module.git \
#    && wget -O - http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz | tar zxfv - \
#    && mv /opt/nginx-$NGINX_VERSION /opt/nginx \
#    && cd /opt/nginx \
#    && ./configure --with-compat --add-dynamic-module=/opt/ngx_http_geoip2_module \
#    && make modules
#
#FROM nginx:$NGINX_VERSION
#
## Copy the compiled GeoIP2 module
#COPY --from=builder /opt/nginx/objs/ngx_http_geoip2_module.so /usr/lib/nginx/modules
#
## Install runtime dependencies and prepare the modules directory
#RUN apt-get update \
#    && apt-get install -y --no-install-recommends --no-install-suggests libmaxminddb0 \
#    && apt-get clean \
#    && rm -rf /var/lib/apt/lists/* \
#    && mkdir -p /etc/nginx/modules-enabled \
#    && chmod -R 644 /usr/lib/nginx/modules/ngx_http_geoip2_module.so \
#    && echo "load_module /usr/lib/nginx/modules/ngx_http_geoip2_module.so;" > /etc/nginx/modules-enabled/50-geoip2.conf

FROM nginx:$NGINX_VERSION
# Copy the index.html file into the NGINX default document root
COPY index.html /usr/share/nginx/html/index.html

# Expose the HTTP port
EXPOSE 80

# Run NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
