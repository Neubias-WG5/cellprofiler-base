FROM ubuntu:16.04

# Install CellProfiler
RUN apt-get update -y   && \
    apt-get upgrade -y  && \
    apt-get install -y     \
        build-essential    \
        cython             \
        git                \
        libmysqlclient-dev \
        libhdf5-dev        \
        libxml2-dev        \
        libxslt1-dev       \
        openjdk-8-jdk      \
        python-dev         \
        python-pip         \
        python-h5py        \
        python-matplotlib  \
        python-mysqldb     \
        python-scipy       \
        python-numpy       \
        python-vigra       \
        python-wxgtk3.0    \
        python-zmq

#RUN update-alternatives --config java

RUN cd / && git clone https://github.com/CellProfiler/CellProfiler.git
RUN cd /CellProfiler && git checkout 2.2.0 && pip install --editable .

#FROM neubiaswg5/neubias-base:latest
# Install Cytomine Python client
RUN apt-get install -y software-properties-common python-software-properties

RUN add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update -y && \
    apt-get install -y python3.6 && \
    apt-get install -y python3.6-dev && \
    apt-get install -y python3.6-venv && \
    apt-get install -y wget

RUN cd /tmp && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python3.6 get-pip.py

RUN pip3 install requests \
    requests-toolbelt \
    six \
    future \
    shapely \
    opencv-python \
    scikit-image \
    imageio

RUN pip3 install https://github.com/Neubias-WG5/AnnotationExporter/archive/master.zip

RUN cd / && \
    git clone https://github.com/cytomine-uliege/Cytomine-python-client.git && \
    cd Cytomine-python-client && \
    python3.6 setup.py build && \
    python3.6 setup.py install

ENTRYPOINT /bin/sh