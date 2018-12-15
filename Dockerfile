FROM openresty/openresty:alpine

RUN apk add --no-cache bash

RUN apk add --no-cache imagemagick ffmpeg

# add crontab file
ADD ./scripts/clean.sh /etc/periodic/daily/clean

ADD ./lib/lua-resty-http/lib/resty/http.lua /usr/local/openresty/lualib/resty/
ADD ./lib/lua-resty-http/lib/resty/http_headers.lua /usr/local/openresty/lualib/resty/

# nginx config
ADD ./nginx.conf /usr/local/openresty/nginx/conf/
ADD ./app /usr/local/openresty/site/lualib/app

ADD ./scripts/run.sh /

CMD ["/run.sh"]

