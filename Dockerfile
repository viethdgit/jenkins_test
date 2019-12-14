COPY src/nginx-1.11.2/ nginx-1.11.2/

RUN echo @testing http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    echo /etc/apk/respositories \
    && apk update \
    && mkdir -p /var/log/php-fpm/ \
    && mkdir -p /usr/local/webclip/conf/ \
    && mkdir -p /srv/www/cliptv/ \
    && apk --no-cache add g++ \
    pcre-dev \
    zlib-dev \
    gd-dev \
    linux-headers \
    openssl-dev \
    geoip-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    freetype-dev \
    sqlite-dev \
    icu-libs \
    libxslt-dev \
    make \
    bash \
    && docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install iconv pdo_mysql pdo_sqlite mysqli gd exif xsl json soap dom zip opcache && \
    docker-php-source delete \
    && cd nginx-1.11.2 \
    && ./configure --prefix=/usr/local/webclip/ \
    --with-debug --without-mail_pop3_module --without-mail_imap_module \
    --without-mail_smtp_module --without-http_scgi_module \
    --without-http_uwsgi_module --with-http_gzip_static_module \
    --with-http_realip_module --with-http_ssl_module --with-http_sub_module \
    --with-ipv6 --with-http_secure_link_module \
    --with-http_image_filter_module --with-http_flv_module --with-http_mp4_module \
    --with-http_stub_status_module --pid-path=/usr/local/webclip/var/run/nginx.pid \
    --conf-path=/usr/local/webclip/conf/nginx.conf --lock-path=/usr/local/webclip/var/lock/subsys/nginx \
    --sbin-path=/usr/local/webclip/sbin/nginx --with-http_v2_module \
    # --with-openssl=/home/nginx-1.11.2/src/http/openssl-1.0.2h \
    --with-file-aio --with-http_geoip_module \
    && make && make install

COPY config/conf/ /usr/local/webclip/conf/
#COPY src/cliptv/ /srv/www/cliptv/
VOLUME /srv/www/cliptv

COPY config/data /
COPY config/cliptv.vn.conf /usr/local/etc/php-fpm.d/
ADD start.sh /start.sh
RUN addgroup -S web && adduser -S web -G web \
    && chown -R web:web /usr/local/webclip/ \
    && chown -R web:web /srv/www/cliptv/ \
    && chmod 777 /start.sh

EXPOSE 80/tcp 443/tcp

CMD ["/start.sh"]