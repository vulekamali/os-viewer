FROM node:8.10-alpine

RUN apk add --update --no-cache --virtual=build-dependencies git

WORKDIR /app
COPY package.json ./

# https://github.com/DmitryBaranovskiy/raphael/issues/993#issuecomment-155957816
RUN git config --global url."https://".insteadOf git:// \
    && npm install --loglevel verbose

COPY docker/settings.json /app/settings.json
COPY . .
RUN npm run build

EXPOSE 8000

CMD cd /app && npm start
