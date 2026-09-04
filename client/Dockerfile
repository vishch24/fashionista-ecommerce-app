# =========================================
# Stage 1: Build the React.js Application
# =========================================
ARG NODE_VERSION=16.14.2-alpine
ARG NGINX_VERSION=alpine3.22

# Use a lightweight Node.js image for building (customizable via ARG)
FROM node:${NODE_VERSION} AS builder

ARG REACT_APP_RAZORPAY_KEY_ID
ENV REACT_APP_RAZORPAY_KEY_ID=${REACT_APP_RAZORPAY_KEY_ID}

# Set the working directory inside the container
WORKDIR /app

# Copy package-related files first to leverage Docker's caching mechanism
COPY package*.json ./

# Install project dependencies using npm ci (ensures a clean, reproducible install)
RUN --mount=type=cache,target=/root/.npm npm ci

# Copy the rest of the application source code into the container
COPY . .

# Build the React.js application (outputs to /app/build)
RUN npm run build

# =========================================
# Stage 2: Prepare Nginx to Serve Static Files
# =========================================
FROM nginxinc/nginx-unprivileged:${NGINX_VERSION} AS runner

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the static build output from the build stage to Nginx's default HTML serving directory
COPY --chown=nginx:nginx --from=builder /app/build /usr/share/nginx/html

# Expose port 8080 to allow HTTP traffic
# Note: The default NGINX container now listens on port 8080 instead of 80
EXPOSE 8080

# Health check configuration
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -q -O /dev/null http://localhost:8080/ || exit 1

# Start Nginx directly with custom config
ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf"]
CMD ["-g", "daemon off;"]