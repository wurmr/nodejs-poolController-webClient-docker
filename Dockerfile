FROM node:lts as builder
WORKDIR /work
RUN npx degit tagyoureit/nodejs-poolController-webClient
RUN npm ci
RUN npm run build:parcel
RUN npx tsc

FROM node:lts-alpine
WORKDIR /usr/local/nodejs-poolController-webClient
COPY --from=builder /work .
ENV NODE_ENV=production
EXPOSE 8080
ENTRYPOINT [ "node",  "./dist/Server.js" ]