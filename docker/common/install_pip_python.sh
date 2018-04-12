#!/bin/bash

set -ex

# Install common dependencies
apt-get update
apt-get install -y --no-install-recommends python3-dev python3-setuptools

# Install pip from source. The python-pip package on Ubuntu Trusty is old
# and upon install numpy doesn't use the binary distribution, and fails to compile it from source.
curl -O https://pypi.python.org/packages/11/b6/abcb525026a4be042b486df43905d6893fb04f05aac21c32c638e939e447/pip-9.0.1.tar.gz
tar zxf pip-9.0.1.tar.gz
pushd pip-9.0.1
python3 setup.py install
popd
rm -rf pip-9.0.1*

pip install numpy decorator six future pyyaml
# install the devel needed for aten
pip install mkl mkl-devel typing

which python3
python3 --version
python3 -c 'import yaml'

# Cleanup package manager
apt-get autoclean && apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
