# Starts First Build Step
FROM node:alpine AS builder
WORKDIR /app
COPY  package.json .
RUN npm install
COPY . .
RUN npm run build

# Starts Nginx Build Step
FROM nginx
# Expose ports externally to a service on beanstalk (AWS)
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# No need define CMD, Nginx Container already do that!