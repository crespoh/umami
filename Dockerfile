# Use official Node Alpine image
FROM node:18-alpine

# Accept build arguments
ARG DATABASE_URL
ARG APP_SECRET

# Set build args as env vars (so Umami's check-env.js can see them)
ENV DATABASE_URL=$DATABASE_URL
ENV APP_SECRET=$APP_SECRET

# Set working directory
WORKDIR /app

# Enable and prepare pnpm
RUN corepack enable && corepack prepare pnpm@8.6.9 --activate

# Copy dependency declarations
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install

# Copy rest of the app
COPY . .

RUN echo "BUILD: DATABASE_URL=$DATABASE_URL"
# Build the app (now that env vars are visible)
RUN pnpm build

# Expose Umami's default port
EXPOSE 3000

# Start the app
CMD ["pnpm", "start"]