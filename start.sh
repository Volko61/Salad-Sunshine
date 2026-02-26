#!/bin/bash

echo "Starting Tailscale..."
# Boot Tailscale in userspace mode (bypasses Salad's network restrictions)
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 &
sleep 5

echo "Authenticating Tailscale..."
# Connect to your Tailnet using your Auth Key
tailscale up --auth-key="${TAILSCALE_AUTHKEY}" --hostname="salad-sunshine" --accept-dns=false

echo "Starting Steam-Headless Desktop..."
# Hand control back to the original container's init system
exec "$@"
