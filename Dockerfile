# Step 1: Build Stage
FROM node:20 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the project for production
RUN npm run build

# Step 2: Serve Stage (using a lightweight web server)
FROM nginx:alpine

# Copy the built app from the previous stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port for Nginx (default port is 80)
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]