FROM node:18-alpine

WORKDIR /app

RUN corepack enable && corepack prepare pnpm@8.6.9 --activate

COPY package.json pnpm-lock.yaml ./
RUN ls -l
RUN pnpm install

COPY . .
RUN pnpm build

EXPOSE 3000
CMD ["pnpm", "start"]