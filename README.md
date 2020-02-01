# UrBackup Client (internet only)

These are my Docker image source files for a internet-only UrBackup client. 

## Running

```
docker run \
  -p 35621:35621 -p 35622:35622 -p 35623:35623 \
  -v /path/to/data:/backup/name:ro \
  -e SERVER_NAME=<UrBackup server name/ip> \
  -e CLIENT_NAME=<this client's name> \
  -e CLIENT_KEY=<this client's auth key>
  mandlm/urbackup-internet-client
```
