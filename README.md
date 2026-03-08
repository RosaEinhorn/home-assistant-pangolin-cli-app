# Pangolin CLI for Home Assistant

[![GitHub Release](https://img.shields.io/github/release/RosaEinhorn/home-assistant-pangolin-cli-app.svg?style=flat-square)](https://github.com/RosaEinhorn/home-assistant-pangolin-cli-app/releases)
[![License](https://img.shields.io/github/license/RosaEinhorn/home-assistant-pangolin-cli-app.svg?style=flat-square)](LICENSE)

> **Note**: This app was created with the assistance of AI.

A Home Assistant app (formerly called add-on) that runs the [Pangolin CLI client](https://github.com/fosrl/cli), enabling your Home Assistant instance to connect to private resources on your Pangolin network.

## About

This add-on allows Home Assistant to act as a Pangolin client, establishing an outbound WireGuard tunnel to your Pangolin server. Once connected, Home Assistant can access private resources (services, APIs, devices) that are hosted behind Pangolin sites (Newt).

### Use Cases

- **Access private APIs or services** from Home Assistant automations
- **Connect to IoT devices** on remote networks
- **Integrate with self-hosted services** without exposing them to the internet
- **Create secure connections** between multiple Home Assistant instances
- **Backup Home Assistant** to private network storage (NAS, file servers)
- **Access private databases** for custom integrations

## Installation

### 1. Add the Repository

1. Navigate to **Settings** → **Add-ons** → **Add-on Store** in Home Assistant
2. Click the **⋮** menu (top right) → **Repositories**
3. Add this repository URL:
   ```
   https://github.com/RosaEinhorn/home-assistant-pangolin-cli-app
   ```
4. Click **Add** → **Close**

### 2. Install the App

1. Find **Pangolin CLI** in the add-on store
2. Click on it and press **Install**
3. Wait for the installation to complete

### 3. Configure

1. Go to the **Configuration** tab
2. Set the following required values:
   - **PANGOLIN_ENDPOINT**: Your Pangolin server URL (e.g., `https://app.pangolin.net`)
   - **CLIENT_ID**: Your Pangolin client ID
   - **CLIENT_SECRET**: Your Pangolin client secret

3. Click **Save**

### 4. Start the App

1. Go to the **Info** tab
2. Enable **Start on boot** (optional but recommended)
3. Click **Start**
4. Check the **Log** tab to verify the connection

## Configuration

### Required Settings

| Option | Description | Example |
|--------|-------------|---------|
| `PANGOLIN_ENDPOINT` | URL of your Pangolin server | `https://app.pangolin.net` |
| `CLIENT_ID` | Client ID from Pangolin dashboard | `client_abc123...` |
| `CLIENT_SECRET` | Client secret from Pangolin dashboard | `secret_xyz789...` |

### Optional Settings

| Option | Description | Example |
|--------|-------------|---------|
| `EXTRA_FLAGS` | Additional CLI flags for pangolin-cli | `--override-dns=false --mtu=1420` |

**Available flags** (see [Pangolin CLI documentation](https://github.com/fosrl/cli) for full list):
- `--override-dns=false` - Disable DNS override
- `--mtu=<value>` - Set MTU size (default: 1280)
- `--log-level=<level>` - Set log level (debug, info, warn, error)

### Getting Client Credentials

1. Log in to your Pangolin dashboard
2. Navigate to **Clients** → **Create Client**
3. Give your client a name (e.g., "Home Assistant")
4. Select the network/organization
5. Copy the **Client ID** and **Client Secret**
6. Paste them into the add-on configuration

## How It Works

```
┌─────────────────┐         ┌──────────────┐         ┌─────────────┐
│ Home Assistant  │────────▶│   Pangolin   │────────▶│  Newt Site  │
│   (Client)      │  Tunnel │    Server    │  Route  │ (Resources) │
└─────────────────┘         └──────────────┘         └─────────────┘
```

1. The add-on creates a WireGuard tunnel from Home Assistant to your Pangolin server
2. Home Assistant receives an IP address on the Pangolin network (e.g., `100.90.128.2`)
3. Routes are automatically configured to reach resources behind Newt sites
4. Home Assistant can now access private resources using their Pangolin IPs or hostnames

## Verification

After starting the add-on, verify the connection:

### Check the Logs

Look for these messages in the add-on logs:
```
✅ Configuration loaded
🔹 Connecting to Pangolin...
```

### Check Network Interface

SSH into your Home Assistant host and run:
```bash
ip addr show pangolin
```

You should see a `pangolin` interface with an IP address.

### Check Routes

```bash
ip route | grep pangolin
```

You should see routes to Pangolin networks through the `pangolin` interface.

### Test Connectivity

From Home Assistant, try accessing a resource on your Pangolin network:
```bash
curl http://100.96.128.10
```
(Replace with an actual resource IP from your Pangolin network)

## Troubleshooting

### App Won't Start

**Check the logs** for error messages:
- `Missing required configuration`: Ensure all three config values are set
- `Failed to create TUN device`: The app needs proper permissions (should work by default)
- `Authentication failed`: Verify your CLIENT_ID and CLIENT_SECRET are correct

### Connection Established But Can't Reach Resources

1. **Verify the client is connected** in your Pangolin dashboard
2. **Check that the Newt site is online** and connected
3. **Verify network configuration** in Pangolin - the client and site must be in the same network
4. **Check Pangolin server logs** for routing issues

### Connection Keeps Dropping

- Check your internet connection stability
- Verify the Pangolin server is reachable
- Check Pangolin server logs for errors
- The add-on will automatically reconnect every 5 seconds

## Architecture

### Supported Architectures

- `amd64` (x86-64)
- `armv7` (32-bit ARM)
- `armhf` (ARM hard float)
- `aarch64` (64-bit ARM)

### Network Requirements

- **Outbound UDP**: The add-on needs to establish an outbound WireGuard connection
- **Host Network Mode**: The add-on runs with `host_network: true` to create the tunnel interface on the host
- **Privileges**: Requires `NET_ADMIN`, `NET_RAW`, and `SYS_ADMIN` capabilities for network interface management

## Advanced

### Accessing Resources from Automations

Once connected, you can access Pangolin resources from Home Assistant automations:

```yaml
automation:
  - alias: "Check Private API"
    trigger:
      - platform: time_pattern
        minutes: "/5"
    action:
      - service: rest_command.check_private_api
        
rest_command:
  check_private_api:
    url: "http://100.96.128.10/api/status"
    method: GET
```

## Support

- **Issues**: [GitHub Issues](https://github.com/RosaEinhorn/home-assistant-pangolin-cli-app/issues)
- **Pangolin Documentation**: [docs.pangolin.net](https://docs.pangolin.net)
- **Pangolin CLI**: [github.com/fosrl/cli](https://github.com/fosrl/cli)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Pangolin](https://pangolin.net) by Fossorial
- [Home Assistant](https://www.home-assistant.io/)
- Home Assistant Community Add-ons base image
- This add-on was created with the assistance of AI

---

**Note**: This is an unofficial community app (formerly called add-on) and is not affiliated with or endorsed by Fossorial or Pangolin.
