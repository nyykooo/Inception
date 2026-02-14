###########################
### DOCKER FILE - NGINX ###
###########################
# The FROM instruction initializes a new build stage and sets the base image for subsequent instructions.
# Using last stable version of debian
FROM debian:bookworm

# Update package lists for apt-get
# The RUN instruction will execute any commands to create a new layer on top of the current image. 
RUN apt-get -y update && \
# Install Nginx web server and OpenSSL for creating certificates
apt-get install -y nginx openssl

RUN pwd
# RUN ./tools/ssl.sh

# The COPY instruction copies a file from source to destiny
COPY ./conf/nginx.conf /etc/nginx/conf.d
COPY ./tools/init.sh /usr/local/bin/

EXPOSE 443

CMD ["/usr/local/bin/init.sh"]