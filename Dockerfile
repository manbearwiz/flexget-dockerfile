#
# Flexget Dockerfile
#
# https://github.com/kmb32123/flexget-dockerfile
#

# Pull base image.
FROM python:2

VOLUME ["/flexget"]
VOLUME ["/input"]
VOLUME ["/output"]

WORKDIR /flexget

ENV FLEXGET_VERSION 1.2.376

ENV LANG en_US.UTF-8

RUN set -x \
  && mkdir -p /usr/src/app \
  && cd /usr/src/app \
  && curl -SL "https://github.com/Flexget/Flexget/archive/${FLEXGET_VERSION}.tar.gz" | tar xz \
  && cd ./Flexget-${FLEXGET_VERSION} \
  && pip install paver \
  && pip install . \
  && pip install -r jenkins-requirements.txt \
  && python setup.py

CMD rm -f /flexget/.config-lock && flexget daemon start
