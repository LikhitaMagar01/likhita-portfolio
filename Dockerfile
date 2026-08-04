# --- stage 1: build the app ---
# starting from a node image so I have npm/node available
# naming it "build" so I can grab files from it later
FROM node:24.14.1 AS build

# everything from here happens inside /app in the container
WORKDIR /app

# vite.config.ts hardcodes a base path for github pages
# this lets me override it to "/" when building for docker
ARG VITE_BASE_PATH=/

# copying just these two files first so docker can cache the npm install step
# if I only change my vue files later, this step won't need to rerun
COPY package.json package-lock.json ./

# rather than npm install, npm ci is a good cmd for not sending inconsistent code to the container where npm install might change the lockfile.
# npm ci would send error when lockfile and package.json file is mismatch which is a good feature.
RUN npm ci

# now copy everything else and actually build the site
COPY . .
RUN npx vite build --base="${VITE_BASE_PATH}"

# note to self: don't set NODE_ENV=production before npm ci in this stage
# it makes npm skip devDependencies, and vite itself is a devDependency
# learned this the hard way when the build failed with "module not found"

# --- stage 2: serve the built files with nginx ---
# this is a totally separate, clean image
# none of the node stuff above comes with it unless I copy it myself
FROM nginx:1.27-alpine AS runtime

# nginx runs as root by default, making a regular user so it doesn't

# IMP
# if the root user is run in nginx then attacker might enter inside the remote source then to host machine.
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# grab only the built site (the dist folder) from the build stage
COPY --from=build /app/dist /usr/share/nginx/html

# use my own nginx config instead of the default one
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

# since nginx will run as appuser now, appuser needs access to
# the folders nginx normally needs as root
RUN chown -R appuser:appgroup /usr/share/nginx/html \
    && chown -R appuser:appgroup /var/cache/nginx \
    && chown -R appuser:appgroup /var/log/nginx \
    && chown -R appuser:appgroup /etc/nginx/conf.d \
    && touch /var/run/nginx.pid \
    && chown appuser:appgroup /var/run/nginx.pid

# switch to the non-root user for everything after this
USER appuser

# just documenting the port, still need -p or ports: to actually expose it
EXPOSE 5173

# lets docker check if the site is actually responding, not just "is the process alive"
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -qO- http://localhost:5173/ || exit 1

# keep nginx running in the foreground
# if it goes to the background like it normally does, docker thinks the container stopped
CMD ["nginx", "-g", "daemon off;"]
