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
apt-get install -y nginx openssl && \
# Generate a self-signed TLS certificate and private key:
## KEY ##
# -newkey rsa:4096     -> create a new RSA key of 4096 bits (Rivest-Shamir-Adleman -> asymmetric cryptographic algorithm)
# -keyout              -> output path for the private key file
# -nodes               -> do not encrypt the private key with a passphrase

## CERTIFICATE ##
# -sha256              -> use SHA-256 for hashing (sha means secure hash algorithm)
# -x509                -> create a self-signed X.509 certificate
# -days 365            -> certificate validity of 365 days
# -out                 -> output path for the certificate file
# -subj                -> set certificate fields (non-interactively)
# C -> Country; ST -> State; L -> Locality; O -> Organization;
# OU -> Organizational unit; CN -> Common Name
openssl \
-newkey rsa:4096 \
-nodes \
-keyout /etc/ssl/private/server.key \
req \
-x509 \
-days 365 \
-sha256 \
-out /etc/ssl/certs/server.crt \
-subj "/C=PT/ST=LIS/L=Lisbon/O=42/OU=42Lisbon/CN=ncampbel.42.fr"

# The COPY instruction copies a file from source to destiny
COPY ./conf/nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]