This has been built on [`manbearwiz's flexget-dockerfile project`](https://github.com/manbearwiz/flexget-dockerfile).  This project has been altered to run on Alpine 3.3.


![License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)
# flexget-dockerfile

Flexget Dockerfile for automated Docker builds.


# What is Flexget?

>FlexGet is a multipurpose automation tool for content like torrents, nzbs, podcasts, comics, series, movies, etc. It can use different kinds of sources like RSS-feeds, html pages, csv files, search engines and there are even plugins for sites that do not provide any kind of useful feeds.

>There are numerous plugins that allow utilizing FlexGet in interesting ways and more are being added continuously.

>FlexGet is extremely useful in conjunction with applications which have watch directory support or provide interface for external utilities like FlexGet.

# How to use this image

## Run on host networking

Note the `-v` argument, this image will expect the `flexget` directory to contain a valid [`config.yml`](http://flexget.com/wiki/Cookbook). Flexget will also use this directory for storing the resulting database and log file. 

```
sudo docker build -t flexget-image .
sudo docker run -d --name flexget -v /flexget/config:/flexget flexget-image
```

## Configuration

here is a sample config.yml file.  This will cheak the rss feed at 5, 15, 35, 45 past every hour, every day. Once a new item has been found it will be downloaded, and then a connection to transmission will be made and the new item will be added to the default location of your trasmission setup.

```
schedules:
  - tasks: [feed1]
    schedule:
      minute: 5,15,35,45

templates:
  tv:
    download: '/output/'
    series:
      - some one
	  - show two
    transmission:
      enabled: yes
      host: server
      port: 9091
      username: username
      password: password

tasks:
  feed1:
    rss: 'http://feed.xml'
    template: tv

```

This will add any files to in this case a transmission server.


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

This image is based on [`python:2-onbuild`](https://registry.hub.docker.com/_/python/), and  [`python:2-alphine`](https://registry.hub.docker.com/_/python/).  To cut down the size of the image it will pull from [Apline 3.3](https://hub.docker.com/_/alpine/), and will build python 2.7 with the onbuild fetures and install trasmissionrpc, and flexget on top.

As of right now, I am looking at anychanges that may be needed, and will move from there.
