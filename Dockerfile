FROM registry.access.redhat.com/ubi8/nodejs-16:1-98.1682303932

USER root

RUN yum install -y bash \
    && yum -y clean all \
    && rm -rf /var/cache/yum

COPY . /web-compilation
WORKDIR /web-compilation

RUN npm install

RUN chmod a+x /web-compilation/app/app.js \
    && chgrp -R 0 /web-compilation && chmod -R g+rwX /web-compilation

RUN chmod 755 /web-compilation/entrypoint.sh

USER 1001

ENTRYPOINT /web-compilation/entrypoint.sh
