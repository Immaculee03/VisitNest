# ─────────────────────────────────────────────
# VisitNest – Multi-stage Dockerfile
# Stage 1: Build  |  Stage 2: Production
# ─────────────────────────────────────────────

# ── STAGE 1: Build ────────────────────────────
FROM node:18-alpine AS builder

# Set working directory inside the container
WORKDIR /app

# Copy package files first (for layer caching)
COPY package*.json ./

# Install ALL dependencies (including devDependencies)
RUN npm install

# Copy the rest of the source code
COPY . .

# ── STAGE 2: Production ───────────────────────
FROM node:18-alpine AS production

# Set working directory
WORKDIR /app

# Copy only production dependencies from builder stage
COPY --from=builder /app/node_modules ./node_modules

# Copy application source code
COPY --from=builder /app .

# Expose the backend API port
EXPOSE 5000

# Set environment to production
ENV NODE_ENV=production

# Start the application
CMD ["node", "server.js"]
