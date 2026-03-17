FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy the static app into nginx web root
COPY . /usr/share/nginx/html

# Cloud Run provides the PORT env var at runtime.
# Create an nginx config that listens on that port.
CMD ["/bin/sh", "-c", "cat >/etc/nginx/conf.d/default.conf <<EOF
server {
    listen ${PORT};
    server_name _;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF
nginx -g 'daemon off;'"]
