FROM unifem/coupler-desktop:latest as base
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR $DOCKER_HOME

ARG BITBUCKET_PASS
ARG BITBUCKET_USER

# libofm
RUN git clone --depth=1 -b next https://${BITBUCKET_USER}:${BITBUCKET_PASS}@bitbucket.org/${BITBUCKET_USER}/libofm.git ./apps/libofm

WORKDIR $DOCKER_HOME
USER root

### 2nd stage
FROM unifem/coupler-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

COPY --from=base $DOCKER_HOME/apps .

RUN echo ". /opt/openfoam5/etc/bashrc\n./configure --python\n./Allwmake\n" > ./libofm/install.sh && \
    cd libofm && bash install.sh
    

# NOTE test image is based on 17.10, where foam6 is not available
# RUN apt-get update -y && apt-get install openfoam6 -y && cd libofm && \
#     echo ". /opt/openfoam5/etc/bashrc\n./Allwclean python\n" > ./clean.sh && bash ./clean.sh && \
#     echo ". /opt/openfoam6/etc/bashrc\n./configure --python\n./Allwmake\n" > ./install.sh && \
#     bash install.sh
  
RUN rm -rf /tmp/*

WORKDIR $DOCKER_HOME
USER root
