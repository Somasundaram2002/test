# syntax=docker/dockerfile:1.7
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm npm ci
COPY . .
CMD ["node","-e","console.log('artifact image built')"]
