# Etapa 1: construir la app
FROM node:20-alpine AS builder

WORKDIR /app

# Variables de Supabase (se inyectan en build; configurar en CapRover como Build Arguments / Env)
ARG VITE_APP_SUPABASE_URL
ARG VITE_APP_SUPABASE_ANON_KEY
ENV VITE_APP_SUPABASE_URL=$VITE_APP_SUPABASE_URL
ENV VITE_APP_SUPABASE_ANON_KEY=$VITE_APP_SUPABASE_ANON_KEY

COPY package.json package-lock.json* ./
RUN npm ci

COPY . .
RUN npm run build

# Etapa 2: servir con nginx
FROM nginx:alpine

# Copiar artefactos de build
COPY --from=builder /app/dist /usr/share/nginx/html

# Configuración nginx para SPA (React Router)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
