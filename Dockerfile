FROM unifem/coupler-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

ARG BITBUCKET_PASS
ARG BITBUCKET_USER

ADD install_libofm /tmp/

# libofm
RUN env BITBUCKET_PASS=$BITBUCKET_PASS BITBUCKET_USER=$BITBUCKET_USER ./install_libofm

RUN rm -rf /tmp/*

RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME
USER root
