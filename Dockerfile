FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Add i386 to enable the installation of multiarch binaries (x86-32)
RUN dpkg --add-architecture i386

# Download the 32-bit libraries and build essentials
RUN apt-get update -y                                                          \
    && apt-get install -y                                                      \
    wget build-essential locales gcc-multilib g++-multilib lib32z1             \
    lib32stdc++6 lib32gcc1 libxt6:i386 libxtst6:i386 expat:i386                \
    fontconfig:i386 libfreetype6:i386 libexpat1:i386 libc6:i386                \
    libgtk-3-0:i386 libcanberra0:i386 libice6:i386 libsm6:i386                 \
    libncurses5:i386 zlib1g:i386 libx11-6:i386 libxau6:i386                    \
    libxdmcp6:i386 libxext6:i386 libxft2:i386 libxrender1:i386

# Set system locales to en_US.UTF-8
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create a group named 'docker' with GID 1000 and a user named 'docker' with UID 1000
RUN groupadd -g 1000 docker \
    && useradd -u 1000 -g docker -m -s /bin/bash docker

# Switch to the newly created user
USER docker

# Define build arguments
ARG HOME=/home/docker
ARG MODELSIM_VERSION=20.1.1.720
ARG MODELSIM_URL=https://cdrdv2.intel.com/v1/dl/getContent/750666/750670?filename=ModelSimSetup-${MODELSIM_VERSION}-linux.run
ARG MODELSIM_DIR="${HOME}/intelFPGA"

# Set the working directory to the ModelSim installation directory
WORKDIR ${MODELSIM_DIR}

# Download the ModelSim installer
RUN wget -c ${MODELSIM_URL} -O modelsim-${MODELSIM_VERSION}-linux.run

# Make the installer executable, run it, and then clean up the installer
RUN chmod a+x modelsim-${MODELSIM_VERSION}-linux.run                           \
    && ./modelsim-${MODELSIM_VERSION}-linux.run --mode unattended              \
    --accept_eula 1 --installdir ${MODELSIM_DIR}                               \                                               
    && rm -rf modelsim-${MODELSIM_VERSION}-linux.run ${MODELSIM_DIR}/uninstall

# Set the working directory to the home directory
WORKDIR ${HOME}

# Create a 'project' directory in the home directory
RUN mkdir project

# Run ModelSim
CMD ["/home/docker/intelFPGA/modelsim_ase/bin/vsim"]