# ---------- Stage 1: Build React ----------
FROM node:16-slim AS build

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all source code
COPY . .

# Build the React app
RUN npm run build


# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine AS production

# Copy build output from the first stage into Nginx web root
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

