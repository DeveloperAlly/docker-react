# as tags the image with a name
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# gets created in the build directory
RUN npm run build

# Config for the run phase - using nginx
FROM nginx
# copying over from the builder phase of this dockerfile. From the app/build dir to nginx serve dir
COPY --from=builder /app/build /usr/share/nginx/html