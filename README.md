flexget-dockerfile
==================

Flexget Dockerfile for automated Docker builds. 

How to use this image
---------------------

###Run on host networking

This example uses host networking for simplicitly. Also note the `-v` argument. This image will expect the directory to contain a valid `config.yml`. Flexget will also use this directory for storing the resulting database and log file.

```
sudo docker run -d --net="host" --name flexget -v /home/kevin/flexget:/flexget kmb32123/flexget-dockerfile
```

Implementation
--------------

This image is based on [`python:2-onbuild`](https://registry.hub.docker.com/_/python/) and consequently [`debian:jessie`](https://registry.hub.docker.com/u/library/debian/).

As of now, the version of Flexget installed will soley depend on the latest version available in the [Python Package Index](https://pypi.python.org/pypi/FlexGet). I may change this in the future to use flexget:master but for right now this suites my needs.
