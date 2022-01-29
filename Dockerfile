## Stage 1
#FROM node:14.18.0-alpine as build-step
#
#RUN mkdir -p /app
#
#WORKDIR /app
#
#COPY package.json /app
#
#RUN npm install
#
#COPY . /app
#
#RUN npm run build
#
## Stage 2
#FROM nginx:1.17.1-alpine
#
#COPY --from=build-step /app/docs /usr/share/nginx/html



# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:14.18.0 as build

# Set the working directory
WORKDIR /usr/local/app

# Add the source code to app
COPY ./ /usr/local/app/

# Install all the dependencies
RUN npm install

# Generate the build of the application
RUN npm run build


# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=build /usr/local/app/dist/demo /usr/share/nginx/html
