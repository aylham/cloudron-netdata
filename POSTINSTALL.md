The netdata configuration folder is `/app/data/etc` therefore to set up
streaming you can add a file `stream.conf using the file explorer and
restart the app.

The name of the node is based on the env variable `CLOUDRON__APP_DOMAIN`


Using this node as a parent streaming node.
[Official documentation here](https://learn.netdata.cloud/docs/streaming/understanding-how-streaming-works#enable-streaming-on-the-parent-node)

Add a file `stream.conf` in `/app/data/etc` using the file manager.
Use the above documentation to know what to put in this file

Basic example :

```
[11111111-2222-3333-4444-555555555555]
    enabled = yes
    default memory mode = dbengine
```
