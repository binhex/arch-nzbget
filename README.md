NZBGet
======

NZBGet - http://nzbget.net/

Latest NZBGet Git Test branch from Arch Linux AUR using Packer to compile.

**Pull image**

```
docker pull binhex/arch-nzbget
```

**Run container**

```
docker run -d -p 6789:6789 --name=<container name> -v <path for media files>:/media -v <path for data files>:/data -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro binhex/arch-nzbget
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

```
http://<host ip>:6789
```

Default credentials

username: nzbget
password: tegbzn6789

