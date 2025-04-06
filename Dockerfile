FROM scratch AS etap1

ADD alpine-minirootfs-3.21.3-x86_64.tar /

RUN apk update && apk upgrade
RUN apk add --update npm && rm -rf /var/cache/apk/*

WORKDIR /usr/app

COPY ./package.json ./

RUN npm install

COPY ./index.js ./

FROM nginx:alpine AS etap2

RUN apk update && apk upgrade 
RUN apk add --update nodejs npm && rm -rf /var/cache/apk/*

COPY --from=etap1 /usr/app /usr/share/nginx/html

COPY ./default.conf /etc/nginx/conf.d/default.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

HEALTHCHECK --interval=10s --timeout=1s --retries=3 \
    CMD curl -f http://localhost:80 || exit 1

ARG VERSION
ENV APP_VERSION=${VERSION:-v1.0.0}

EXPOSE 80

CMD ["/entrypoint.sh"]