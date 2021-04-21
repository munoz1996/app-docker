FROM node:10-alpine

LABEL   email=smunoz@dacaballero
LABEL   net.dcaballero.description="Image with web app developed in angular"
LABEL   net.dcaballero.vendor=dcaballero.net
LABEL   net.dcaballero.copyright=dcaballero.net
LABEL   net.dcaballero.version=1.0.0
LABEL   net.dcaballero.project=acme

RUN apk update \
&& apk add bash 

RUN mkdir /app

WORKDIR /app

COPY package.json /app/package.json
COPY . /app/

RUN npm install
RUN npm install -g @angular/cli@7.3.9
RUN npm install rxjs-compat --save
RUN npm install @angular/http@latest
RUN npm install @angular/platform-browser --save

COPY serve-site.sh /app/serve-site.sh

RUN chmod 755 /app/serve-site.sh

RUN  ln -s /app/serve-site.sh /bin/serve-site

ENTRYPOINT ["serve-site"]

EXPOSE 4200