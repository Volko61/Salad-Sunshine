# Force the AMD64 platform so WSL doesn't get confused, and use the correct repo
FROM --platform=linux/amd64 josh5/steam-headless:latest

# Switch to root to install network tools
USER root

# Install Tailscale
RUN apt-get update && apt-get install -y curl net-tools iputils-ping
RUN curl -fsSL https://tailscale.com/install.sh | sh

# Copy in our custom boot script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Override the boot process
ENTRYPOINT ["/start.sh"]
# /init is the standard boot command for the steam-headless base system
CMD ["/init"]
