# RocDev Deployment

## Spin up server on DigitalOcean

First, install `doctl` for your OS.

Run these commands to spin up a server.

```bash
./create_infrastructure.sh
doctl compute ssh rdapp@rocdev-v2
```

To destroy the server, carefully run this command.

```bash
doctl compute droplet delete rocdev-v2
```
