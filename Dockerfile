FROM unifem/coupler-desktop:latest as base

USER root
WORKDIR $DOCKER_HOME

ARG BITBUCKET_PASS
ARG BITBUCKET_USER

# lbcalculix
RUN git clone --depth=1 -b next https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/libcalculix.git ./apps/libcalculix

WORKDIR $DOCKER_HOME
USER root


### 2nd stage
FROM unifem/coupler-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

COPY --from=base $DOCKER_HOME/apps .

RUN cd libcalculix && \
    make && \
    make test
    
RUN rm -rf /tmp/*

WORKDIR $DOCKER_HOME
USER root
