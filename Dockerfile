FROM nginx

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Script for substituting environment variables
COPY ./substitute-env-variables.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

# Substitute environment variables in nginx configuration
ENTRYPOINT ["./entrypoint.sh", "/etc/nginx/conf.d/default.conf", "PORT0,LOGIN_PATH,BACKEND_PATH,BACKEND_HOST,PB_PATH,PB_HOST,BPMN_PATH,BPMN_HOST,FRONTEND_PATH,FRONTEND_HOST"]

# Start server
CMD ["nginx", "-g", "daemon off;"]
