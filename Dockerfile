FROM nginx:stable-alpine
RUN apk add --no-cache bash cgit fcgiwrap git git-daemon perl
ADD rootfs /
VOLUME [ "/data" ]
