# ---------------------------------------------------
# Stage 1: Build & Dependency Resolution
# ---------------------------------------------------
FROM node:16.14.2-alpine AS builder

WORKDIR /app

# Install build tools needed to compile native dependencies like bcrypt
RUN apk add --no-cache build-base g++ make python3

# Copy package-related files first to leverage Docker's caching mechanism
COPY package*.json ./

# Install project dependencies using npm ci (ensures a clean, reproducible install)
RUN --mount=type=cache,target=/root/.npm npm ci --omit=dev

# ---------------------------------------------------
# Stage 2: Final Secure Runtime
# ---------------------------------------------------
FROM node:16.14.2-alpine AS runner

WORKDIR /app

# Copy the verified, non-root modules over from the builder stage
COPY --from=builder --chown=node:node /app/node_modules ./node_modules

# Copy the source code into the container as a non-root user.
COPY --chown=node:node . .

# Use a built-in non-root user for security best practices
USER node

# Health check configuration
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -q -O /dev/null http://localhost:5000/health || exit 1

# Expose the port that the application listens on.
EXPOSE 5000

CMD ["node", "index.js"]