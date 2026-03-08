# Use the official Home Assistant add-on base image
FROM ghcr.io/hassio-addons/base:14.0.0

# Define the Pangolin CLI version
ARG PANGOLIN_CLI_VERSION=0.5.1
ENV PANGOLIN_CLI_VERSION=${PANGOLIN_CLI_VERSION}

# Install dependencies
RUN apk add --no-cache bash curl jq

# Detect system architecture and download the correct Pangolin CLI binary
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        curl -fsSL -o /usr/bin/pangolin-cli https://github.com/fosrl/cli/releases/download/${PANGOLIN_CLI_VERSION}/pangolin-cli_linux_amd64; \
    elif [ "$ARCH" = "aarch64" ]; then \
        curl -fsSL -o /usr/bin/pangolin-cli https://github.com/fosrl/cli/releases/download/${PANGOLIN_CLI_VERSION}/pangolin-cli_linux_arm64; \
    elif [ "$ARCH" = "armv7l" ]; then \
        curl -fsSL -o /usr/bin/pangolin-cli https://github.com/fosrl/cli/releases/download/${PANGOLIN_CLI_VERSION}/pangolin-cli_linux_arm32; \
    elif [ "$ARCH" = "armv6l" ]; then \
        curl -fsSL -o /usr/bin/pangolin-cli https://github.com/fosrl/cli/releases/download/${PANGOLIN_CLI_VERSION}/pangolin-cli_linux_arm32v6; \
    elif [ "$ARCH" = "riscv64" ]; then \
        curl -fsSL -o /usr/bin/pangolin-cli https://github.com/fosrl/cli/releases/download/${PANGOLIN_CLI_VERSION}/pangolin-cli_linux_riscv64; \
    else \
        echo "❌ ERROR: Unsupported architecture: $ARCH"; exit 1; \
    fi && \
    chmod +x /usr/bin/pangolin-cli

# Copy and prepare run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Start the add-on
ENTRYPOINT ["/run.sh"]