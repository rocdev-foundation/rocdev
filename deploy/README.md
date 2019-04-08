# RocDev Deployment

## Spin up server on DigitalOcean

First, install `doctl` for your OS.

Run these commands to spin up a server.

```bash
doctl compute droplet create rocdev-v2 --wait --region nyc1 --image ubuntu-18-04-x64 --size s-1vcpu-1gb --user-data-file user-data.yml
doctl compute ssh rdapp@rocdev-v2
```

To destroy the server, carefully run this command.

```bash
doctl compute droplet delete rocdev-v2
```
