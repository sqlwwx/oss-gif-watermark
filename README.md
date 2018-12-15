```
docker build -t oss-gif-watermark .

docker run \
-v $PWD/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
-v $PWD/app:/usr/local/openresty/site/lualib/app \
--name oss-gif-watermark \
-p 8080:80 \
-t -i oss-gif-watermark:latest /run.sh

docker exec oss-gif-watermark wget -qO-
http://127.0.0.1:8080/watermark/aW1ncy8yMDE4MTIwNi15dG9KVmhNRi5naWY_eC1vc3MtcHJvY2Vzcz1pbWFnZS9yZXNpemUsd180MDA=/d3hRcmNvZGUvRmcyZzBIUkxCSmR3TG1FOUUyQ0I2TnNPVVJ5Ql9xcmNvZGU_eC1vc3MtcHJvY2Vzcz1pbWFnZS9yZXNpemUsd18zMDAsaF80MDA=/200_90
```
