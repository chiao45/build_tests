FROM unifem/coupler-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

ARG BITBUCKET_PASS
ARG BITBUCKET_USER

# lbcalculix
RUN git clone --depth=1 -b next https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/libcalculix.git && \
    cd libcalculix && \
    make && \
    make test

RUN rm -rf /tmp/*

RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME
USER root
