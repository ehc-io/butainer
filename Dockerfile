FROM ubuntu:20.04

# Install Essential Packages
RUN apt update && apt -y upgrade
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa

# Update packages and install any necessary dependencies
RUN apt-get update && \
    # apt-get install -y sudo git python3.11 python3.11-dev gcc
    apt-get install -y sudo git python3.10 python3.10-dev gcc
    
RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

# install gcloud util
RUN apt-get install -y apt-transport-https ca-certificates gnupg curl
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get -y install google-cloud-cli

RUN apt-get install -y zsh unzip vim ffmpeg 
RUN apt-get install -y net-tools iputils-ping host traceroute libmagic-dev
# RUN pip3 install pydub openai colorama pymongo python-slugify bs4 scrapy langdetect
# RUN pip3 install langchain chromadb youtube-transcript-api pytube tiktoken llama_index openai-whisper llama-cpp-python

RUN apt install -y tesseract-ocr libtesseract-dev
# RUN pip3 install poppler-utils pytesseract
# RUN pip3 install 'git+https://github.com/facebookresearch/detectron2.git' 
# RUN pip3 install unstructured[local-inference]
# RUN pip3 install unstructured pypdf tabulate pdf2image layoutparser Pillow python-magic

# RUN pip3 install google-cloud-aiplatform google-cloud-speech google-auth

# Copy application files to the container
COPY  to-copy workdir

# Set the working directory to the application directory
WORKDIR /workdir/
RUN ./zsh_install.sh

# Expose any necessary ports
# EXPOSE 

# Define the command to run the application
CMD /bin/zsh