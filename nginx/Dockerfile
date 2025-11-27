FROM nginx:latest

WORKDIR /app
# remove the default nginx config
RUN rm -fr /etc/nginx/conf.d/default.conf
# copy the nginx config files to the container
COPY . .
# generate the ssl files
RUN chmod +x ./generate-ssl.sh && ./generate-ssl.sh && rm ./generate-ssl.sh 
# move the ssl files to the correct location
RUN mkdir -p /etc/nginx/ssl && \
    mv ./ssl/nginx.crt /etc/nginx/ssl/nginx.crt && \
    mv ./ssl/nginx.key /etc/nginx/ssl/nginx.key
# copy the nginx config files to the container
COPY ./vp-app.conf /etc/nginx/conf.d/vp-app.conf

EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]