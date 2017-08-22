# Creates docker container that runs bhx-xcede tools
#
#

# Start with neurodebian image
FROM neurodebian:xenial
MAINTAINER Flywheel <support@flywheel.io>

RUN echo deb http://neurodeb.pirsquared.org data main contrib non-free >> /etc/apt/sources.list.d/neurodebian.sources.list
RUN echo deb http://neurodeb.pirsquared.org xenial main contrib non-free >> /etc/apt/sources.list.d/neurodebian.sources.list

# Install packages
RUN apt-get update \
    && apt-get install -y \
    lsb-core \
    bsdtar \
    zip \
    unzip \
    gzip \
    curl \
    git \
    jq \
    python-pip

# Download bhx-xcede tools
ENV VERSION=bxh_xcede_tools-1.11.14-lsb30.x86_64
ENV LINK=https://www.nitrc.org/frs/download.php/10144/${VERSION}.tgz
RUN curl -#L  $LINK | bsdtar -xf- -C /opt/
ENV PATH=$PATH:/opt/${VERSION}/bin

# Install webpage2html
ENV COMMIT=4dec20eba862335aaf1718d04b313bdc96e7dc8e
ENV URL=https://github.com/zTrix/webpage2html/archive/$COMMIT.zip
RUN curl -#L  $URL | bsdtar -xf- -C /opt/
WORKDIR /opt
RUN mv webpage2html-$COMMIT webpage2html
RUN pip install -r webpage2html/requirements.txt

# Make directory for flywheel spec (v0)
ENV FLYWHEEL /flywheel/v0
WORKDIR ${FLYWHEEL}

# Add executables
COPY run ${FLYWHEEL}/run

# Add manifest
COPY manifest.json ${FLYWHEEL}/manifest.json

# Configure entrypoint
ENTRYPOINT ["/flywheel/v0/run"]
