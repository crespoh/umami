# Dockerfile
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install pnpm
RUN corepack enable && corepack prepare pnpm@8.6.9 --activate

# Copy package.json and lockfile
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install

# Copy rest of the app
COPY . .

# Build the app
RUN pnpm build

# Expose the port Umami runs on
EXPOSE 3000

# Start the app
CMD ["pnpm", "start"]