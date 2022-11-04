#!/bin/bash

SCRIPTS_PATH=$PWD
cd $SCRIPTS_PATH/software

#zmq
tar zxvf zeromq-4.2.2.tar.gz -C .
cd zeromq-4.2.2
./configure
make -j8
make install
