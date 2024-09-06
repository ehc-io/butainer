FROM nvidia/cuda:11.6.2-base-ubuntu20.04

# Install Essential Packages
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y software-properties-common curl
RUN add-apt-repository ppa:deadsnakes/ppa

# Update packages and install any necessary dependencies
RUN apt-get update && \
    apt-get install -y sudo git python3.10 python3.10-dev gcc

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Install NVIDIA Container Toolkit
RUN distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
    && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add - \
    && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list

RUN apt-get update && apt-get install -y nvidia-container-toolkit

# Install CUDA Toolkit and cuDNN
RUN apt-get install -y cuda-toolkit-11-6 libcudnn8

# Install gcloud util
# RUN apt-get install -y apt-transport-https ca-certificates gnupg curl
# RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# RUN apt-get update && apt-get -y install google-cloud-cli

RUN apt-get install -y zsh unzip vim ffmpeg 
RUN apt-get install -y net-tools iputils-ping host traceroute libmagic-dev

# Copy application files to the container
COPY to-copy workdir

# Set the working directory to the application directory
WORKDIR /workdir/
RUN ./zsh_install.sh

# Set environment variables for CUDA
ENV PATH /usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:${LD_LIBRARY_PATH}

# Expose any necessary ports
# EXPOSE 

# Define the command to run the application
CMD /bin/zsh