![Docker Stars Shield](https://img.shields.io/docker/stars/kmb32123/flexget-dockerfile.svg?style=flat-square)
![Docker Pulls Shield](https://img.shields.io/docker/pulls/kmb32123/flexget-dockerfile.svg?style=flat-square)
![License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)
# flexget-dockerfile

Flexget Dockerfile for automated Docker builds.


# What is Flexget?

>FlexGet is a multipurpose automation tool for content like torrents, nzbs, podcasts, comics, series, movies, etc. It can use different kinds of sources like RSS-feeds, html pages, csv files, search engines and there are even plugins for sites that do not provide any kind of useful feeds.

>There are numerous plugins that allow utilizing FlexGet in interesting ways and more are being added continuously.

>FlexGet is extremely useful in conjunction with applications which have watch directory support or provide interface for external utilities like FlexGet.

# How to use this image

## Run on host networking

This example uses host networking for simplicity. Also note the `-v` arguments. This image will expect the `flexget` directory to contain a valid [`config.yml`](http://flexget.com/wiki/Cookbook). Flexget will also use this directory for storing the resulting database and log file. The other directories, `input` and `output` are essentially working directories for Flexget. The intention is that the `input` directory is where files are downloaded to (from transmission, youtube-dl, etc) and the `output` directory is where the sorted and renamed files will be moved to; however, this can all be changed via the Flexget configuration file.

```
sudo docker run -d --net="host" --name flexget -v /etc/localtime:/etc/localtime:ro -v /home/kevin/flexget:/flexget -v /home/kevin/Downloads:/input -v /home/kevin/media:/output kmb32123/flexget-dockerfile
```

## Configuration

Because of the way the volumes are attached to the host, paths can be very simple. An example of a task configration that sorts tv episode looks like so:

```
sort-tvseries:
  find:
    path: /input/tv
    regexp: '.*\.(mkv|mp4)$'
    recursive: yes
  template: tv
  move:
    to: /output/video/tv/{{series_name}}/Season {{series_season|pad(2)}}
    filename: 'S{{series_season|pad(2)}} E{{series_episode|pad(2)}} {{tvdb_ep_name}}'
```

## View log information

To monitor the flexget logs (highly recommended) simply run:

```
sudo docker logs -f flexget
```

## Run out of schedule

Sometimes you don't want to wait for the flexget process to kick on from the scheduler. In these cases you can simply enter:

```
sudo docker exec -it flexget flexget execute
```

Note the first `flexget` is the container name, and the second is the CLI command. This will run all tasks regardless of scheduling.

# Implementation

This image is based on [`python:2-onbuild`](https://registry.hub.docker.com/_/python/) and consequently [`debian:jessie`](https://registry.hub.docker.com/u/library/debian/).

As of now, the version of Flexget installed will soley depend on the latest version available in the [Python Package Index](https://pypi.python.org/pypi/FlexGet). I may change this in the future to [manually install](https://github.com/Flexget/Flexget#how-to-use-git-checkout) from [flexget:master](https://github.com/Flexget/Flexget) but for right now this suites my needs.
