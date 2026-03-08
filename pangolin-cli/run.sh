#!/usr/bin/env bash
set -e

echo "🔹 Starting Pangolin CLI..."

CONFIG_PATH="/data/options.json"

if [[ ! -f "$CONFIG_PATH" ]]; then
    echo "❌ ERROR: Configuration file not found at $CONFIG_PATH"
    exit 1
fi

PANGOLIN_ENDPOINT=$(jq -r '.PANGOLIN_ENDPOINT' "$CONFIG_PATH")
CLIENT_ID=$(jq -r '.CLIENT_ID' "$CONFIG_PATH")
CLIENT_SECRET=$(jq -r '.CLIENT_SECRET' "$CONFIG_PATH")

if [[ -z "$PANGOLIN_ENDPOINT" || -z "$CLIENT_ID" || -z "$CLIENT_SECRET" || "$PANGOLIN_ENDPOINT" == "null" || "$CLIENT_ID" == "null" || "$CLIENT_SECRET" == "null" ]]; then
    echo "❌ ERROR: Missing required configuration"
    echo "   Please configure PANGOLIN_ENDPOINT, CLIENT_ID, and CLIENT_SECRET"
    exit 1
fi

echo "✅ Configuration loaded"
echo "   Endpoint: $PANGOLIN_ENDPOINT"
echo "   Client ID: $CLIENT_ID"

while true; do
    echo "🔹 Connecting to Pangolin..."
    /usr/bin/pangolin-cli up --attach \
        --id "$CLIENT_ID" \
        --secret "$CLIENT_SECRET" \
        --endpoint "$PANGOLIN_ENDPOINT" || true

    echo "⚠️  Connection lost. Reconnecting in 5 seconds..."
    sleep 5
done

# Made with Bob
