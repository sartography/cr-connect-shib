FROM nginx:alpine

ENV BUILD_DEPS="gettext curl"  \
    RUNTIME_DEPS="libintl"

RUN set -x && \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    cp /usr/bin/curl /usr/local/bin/curl && \
    apk del build_deps

RUN apk add --no-cache bash

COPY nginx.conf /etc/nginx/nginx.conf

# Script for substituting environment variables
COPY ./substitute-env-variables.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

# Substitute environment variables in nginx configuration
ENTRYPOINT ["./entrypoint.sh", "/etc/nginx/nginx.conf", "PORT0,LOGIN_PATH,BACKEND_PATH,BACKEND_HOST,PB_PATH,PB_HOST,BPMN_PATH,BPMN_HOST,FRONTEND_PATH,FRONTEND_HOST"]

# Start server
CMD ["nginx", "-g", "daemon off;"]
