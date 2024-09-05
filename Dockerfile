# Adapted from Rstudio image: https://github.com/rstudio/r-docker/blob/main/4.4/jammy/Dockerfile

ARG BASE_IMAGE=rstudio/r-base
FROM ${BASE_IMAGE}:jammy

ARG R_VERSION=4.4.1
ARG OS_IDENTIFIER=ubuntu-2204

# Install R
RUN wget https://cdn.posit.co/r/${OS_IDENTIFIER}/pkgs/r-${R_VERSION}_1_amd64.deb && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -f -y ./r-${R_VERSION}_1_amd64.deb && \
    ln -s /opt/R/${R_VERSION}/bin/R /usr/bin/R && \
    ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/bin/Rscript && \
    ln -s /opt/R/${R_VERSION}/lib/R /usr/lib/R && \
    rm r-${R_VERSION}_1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

# Install renv    
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"

# Copy renv.lock file
WORKDIR /project
COPY renv.lock renv.lock

# set path for renv
ENV RENV_PATHS_LIBRARY renv/library

# restore packages
RUN R -e "renv::restore()"
