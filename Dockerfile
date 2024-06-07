FROM python:2.7.18-buster

# Update the package repository and install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    wget \
    zlib1g-dev \
    liblzma-dev \
    libbz2-dev \
    unzip \
    libncurses5-dev \
    libncursesw5-dev \
    bedtools

# Install HTSLIB
RUN wget https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2  && \
  tar -vxjf htslib-1.9.tar.bz2  && \
  rm htslib-1.9.tar.bz2 && \
  cd htslib-1.9  && \
  make && \
  make install && \
  cd .. && \
  rm -rf htslib-1.9

# Install SAMTOOLS
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
  tar -vxjf samtools-1.9.tar.bz2 && \
  rm samtools-1.9.tar.bz2 && \
  cd samtools-1.9 && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -r samtools-1.9

# install wavelets
RUN wget http://staff.washington.edu/dbp/WMTSA/NEPH/wavelets.tgz && \
  tar -xvf wavelets.tgz && \
  rm -r wavelets.tgz && \
  cd wavelets/src && \
  make && \
  cp ../bin/wavelets /usr/bin/ && \
  cd ../.. && \
  rm -r wavelets

# install Repliscan
RUN pip install git+https://github.com/eriksf/repliscan.git

# Set a working directory
WORKDIR /data

# Command to run when the container starts
CMD ["bash"]
