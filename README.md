# alpine-s6-nginx
Docker container with NGINX and S6 overlay on top of Alpine Linux

## Usage
```
docker create \
    --name nginx \
    -v <path to config folder>:/config
    -e PUID=<uid> -e PGID=<gid>
    -e TZ=<timezone> \
    -e EXTRA_PACKAGES=<packages>
    -e REPOSITORIES=<repositories>
    -p 80:80 -p 443:443
    dimaj/nginx
```

## Parameters
parameter name      | required  | description
--------------      | --------  | -----------
`-p 80` and `- 443` | yes       | exposed ports
`-v /config`        | no        | where NGINX configuration lives (e.g. `nginx.conf`)
`-e PUID`           | no        | User ID of `nginx` user [default 1000]
`-e PGID`           | no        | Group ID of `www-data` group [default 1000]
`e TZ`              | no        | Timezone of container. See [wiki](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for valid timezone names
`-e REPOSITORIES`   | no        | List of package repositories to include in order to install custom packages. Multiple repositories need to be separated by `,`
`-e EXTRA_PACKAGES` | no        | List of packages to install. Multiple packages need to be separated by `,` or ` ` (space)

### Why do I need to specify `PUID` and `PGID`?
Sometimes there are file permission issues between host and container when `-v` flag is used. To metigate this, you can change the `uid` and `gid` of `nginx` user and `www-data` group to match your ids on your host machine. To find your ids, run the following command:
```
id <username>
```

## What kind of packages can I install?
This image is based off Alipine Linux 3.6. By default the following repositores are included [main](http://dl-4.alpinelinux.org/alpine/v3.6/main) and [community](http://dl-4.alpinelinux.org/alpine/v3.6/community). You may choose to include [releases](http://dl-4.alpinelinux.org/alpine/v3.6/releases) or some other repository.

## Extra options
If there is extra processing that you need to do before your container is operational for your purpose, you can add extra init scripts by providing 1 or more script files via
```
-v /path/to/my/script/file:/etc/cont-init.d/99-my-script
```
NOTE: In the command above, your script does not have to start with `99`, but it **must not** start with either `01`, `02`, `03`


