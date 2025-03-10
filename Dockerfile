FROM nginx:stable-alpine
RUN apk add --no-cache bash cgit fcgiwrap spawn-fcgi git git-daemon perl perl-cgi
ADD rootfs /
VOLUME [ "/data" ]
