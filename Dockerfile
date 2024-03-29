FROM redis:5.0-alpine

MAINTAINER Carrey (heartwarm@golfzon.com)

## Copy Redis File
## 복사/추가 하는파일의 Container내 경로는 항상 절대경로로 작성하여야 한다.
RUN rm -rf /usr/local/bin/docker-entrypoint.sh
ADD redis.conf /usr/local/bin/redis.conf
ADD docker-entrypoint.sh /usr/local/bin

## change access authority
RUN chmod 755 /usr/local/bin/redis.conf
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

RUN chown redis:redis /usr/local/bin/redis.conf
RUN chown redis:redis /usr/local/bin/docker-entrypoint.sh

EXPOSE $CLIENTPORT
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD [ "redis-server","/usr/local/bin/redis.conf" ]