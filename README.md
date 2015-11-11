![Shippable Shield](https://img.shields.io/shippable/56340f801895ca4474223cf7/build-flexget.svg?style=flat-square)

flexget-dockerfile
==================

Flexget Dockerfile for automated Docker builds. 

How to use this image
---------------------

###Run on host networking

This example uses host networking for simplicitly. Also note the `-v` arguments. This image will expect the `flexget` directory to contain a valid `config.yml`. Flexget will also use this directory for storing the resulting database and log file. The `input` directory should contain the files that have been downloaded (from transmission, youtube-dl, etc). The ouput directory is where the sorted and renamed files will be moved to.

```
sudo docker run -d --net="host" --name flexget -v /home/kevin/flexget:/flexget -v /home/kevin/Downloads:/input -v /home/kevin/media:/output kmb32123/flexget-dockerfile
```

###View log information

To monitor the fleget logs (highly recommended) simply run:

```
sudo docker logs -f flexget
```

###Run out of schedule

Someimes you dont want to wait for the flexget process to kick on from the scheduler. In these cases you can simply enter:

```
sudo docker exec -it flexget flexget execute
```

Note the first `flexget` is the container name, and the second is the CLI command. This will run all tasks regardless of scheduling.

Implementation
--------------

This image is based on [`python:2-onbuild`](https://registry.hub.docker.com/_/python/) and consequently [`debian:jessie`](https://registry.hub.docker.com/u/library/debian/).

As of now, the version of Flexget installed will soley depend on the latest version available in the [Python Package Index](https://pypi.python.org/pypi/FlexGet). I may change this in the future to [manually install](https://github.com/Flexget/Flexget#how-to-use-git-checkout) from [flexget:master](https://github.com/Flexget/Flexget) but for right now this suites my needs.
