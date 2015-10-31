#
# Flexget Dockerfile
#
# https://github.com/kmb32123/flexget-dockerfile
#

# Pull base image.
FROM python:2-onbuild

VOLUME ["/flexget"]
VOLUME ["/input"]
VOLUME ["/output"]

WORKDIR /flexget

ENV FLEXGET_VERSION 1.2.376

RUN set -x \
  && mkdir -p /usr/src/app \
  && cd /usr/src/app \
  && curl -SL "https://github.com/Flexget/Flexget/archive/${FLEXGET_VERSION}.tar.gz" | tar xz \
  && pip install paver \
  && pip install . \
  && pip install -r jenkins-requirements.txt \
  && python setup.py

CMD rm -f /flexget/.config-lock && flexget daemon start
