#FROM digitallyseamless/nodejs-bower-grunt:4-onbuild
FROM digitallyseamless/nodejs-bower-grunt:4

# Setup build folder
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install
COPY bower.json .bowerrc* /usr/src/app/
RUN bower install
COPY . /usr/src/app/
RUN grunt build --force
ENV NODE_ENV production

RUN npm install -g http-server

WORKDIR /usr/src/app/dist

CMD ["http-server", "-p", "8000"]


#CMD ["grunt", "serve"]