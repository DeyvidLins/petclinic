mkdir ../certificates


# Generate Root Key rootCA.key with 2048
openssl genrsa -passout pass:"password" -des3 -out ../certificates/rootCA.key 2048

# Generate Root PEM (rootCA.pem) with 1024 days validity.
openssl req -passin pass:"password"  -x509 -new -nodes -key ../certificates/rootCA.key -sha256 -days 1024 -out ../certificates/rootCA.pem 
#Country Name (2 letter code) [AU]:US
#State or Province Name (full name) [Some-State]:Random
#Locality Name (eg, city) []:Random
#Organization Name (eg, company) [Internet Widgits Pty Ltd]:Global Security
#Organizational Unit Name (eg, section) []:IT Department
#Common Name (e.g. server FQDN or YOUR name) []:Local Certificate
#Email Address []:



# Generate nexus Cert
openssl req  -new -sha256 -nodes -out ../certificates/nexus.csr -newkey rsa:2048 -keyout ../certificates/nexuskey.pem
#Country Name (2 letter code) [AU]:US
#State or Province Name (full name) [Some-State]:Random
#Locality Name (eg, city) []:Random
#Organization Name (eg, company) [Internet Widgits Pty Ltd]:Global Security
#Organizational Unit Name (eg, section) []:IT Department  
#Common Name (e.g. server FQDN or YOUR name) []:localhost
#Email Address []:

openssl x509 -req -passin pass:"password" -in ../certificates/nexus.csr -CA ../certificates/rootCA.pem -CAkey ../certificates/rootCA.key -CAcreateserial -out ../certificates/nexuscert.crt -days 500 -sha256 
#-extfile <(printf "subjectAltName=DNS:localhost,DNS:nexus-repo")
cd ../nginx/
echo $PWD

# Making Build Context for Dockerfile
cp ../certificates/nexuscert.crt nexuscert.crt
cp ../certificates/nexuskey.pem nexuskey.pem

# Docker build nginx image
docker build --no-cache -t nginx-nexusproxy .

cd ../
cd infra
echo $PWD

# Run nginx and nexus containers
docker-compose up -d
