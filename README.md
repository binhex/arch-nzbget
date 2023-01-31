**Application**

[NZBGet](http://nzbget.net/)

**Description**

NZBGet is a cross-platform binary newsgrabber for nzb files, written in C++. It supports client/server mode, automatic par-check/-repair, web-interface, command-line interface, etc. NZBGet requires low system resources and runs great on routers, NAS-devices and media players.

**Build notes**

Latest stable release from Arch Linux repo.

**Usage**
```
docker run -d \
    -p 6789:6789 \
    --name=<container name> \
    -v <path for media files>:/media \
    -v <path for data files>:/data \
    -v <path for config files>:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e UMASK=<umask for created files> \
    -e PUID=<uid for user> \
    -e PGID=<gid for user> \
    binhex/arch-nzbget
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

`http://<host ip>:6789`

username:- nzbget
password:- tegbzn6789

**Example**
```
docker run -d \
    -p 6789:6789 \
    --name=nzbget \
    -v /media/movies:/media \
    -v /apps/docker/sabnzbd/watched:/data \
    -v /apps/docker/nzbget:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e UMASK=000 \
    -e PUID=0 \
    -e PGID=0 \
    binhex/arch-nzbget
```

**Notes**

User ID (PUID) and Group ID (PGID) can be found by issuing the following command for the user you want to run the container as:-

```
id <username>
```
___
If you appreciate my work, then please consider buying me a beer  :D

[![PayPal donation](https://www.paypal.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=MM5E27UX6AUU4)

[Documentation](https://github.com/binhex/documentation) | [Support forum](http://forums.unraid.net/index.php?topic=45843.0)