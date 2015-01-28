#
# Flexget Dockerfile
#
# https://github.com/kmb32123/flexget-dockerfile
#


# Pull base image.
FROM python:2-onbuild

VOLUME ["/flexget"]

WORKDIR /flexget

CMD flexget daemon start
