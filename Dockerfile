FROM ubuntu:20.04

# Install Essential Packages
RUN apt update && apt -y upgrade
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa

# Update packages and install any necessary dependencies
RUN apt-get update && \
    # apt-get install -y sudo git python3.11 python3.11-dev gcc
    apt-get install -y sudo git python3.11 python3.11-dev gcc
    
RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata


RUN apt-get install -y zsh unzip vim ffmpeg 
RUN apt-get install -y net-tools iputils-ping host traceroute

# Copy application files to the container
COPY  to-copy workdir

# Set the working directory to the application directory
WORKDIR /workdir/
RUN ./zsh_install.sh
RUN echo "source /mnt/storage/toolbox/containers/aliases" >> /root/.zshrc
RUN sed -i 's|# export PATH=$HOME\/bin:\/usr\/local\/bin:$PATH|export PATH=/mnt/storage/toolbox/common/:/mnt/storage/toolbox/containers:$PATH|g' /root/.zshrc

# Expose any necessary ports
# EXPOSE 

# Define the command to run the application
CMD ["/bin/zsh"]