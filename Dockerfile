FROM nginx:alpine

RUN set -x && apk add --update --no-cache bash libintl gettext curl

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /etc/nginx/html/index.html

# Script for substituting environment variables
COPY ./substitute-env-variables.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

# Substitute environment variables in nginx configuration
ENTRYPOINT ["./entrypoint.sh", "/etc/nginx/nginx.conf", "PORT0,PORT1,LOGIN_PATH,BACKEND_PATH,BACKEND_HOST,\
PB_PATH,PB_HOST,BPMN_PATH,BPMN_HOST,FRONTEND_PATH,FRONTEND_HOST"]

# Start server
CMD ["nginx", "-g", "daemon off;"]
