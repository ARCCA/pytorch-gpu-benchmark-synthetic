#!/bin/bash
# Automatic build script
# Be defensive
set -eu
# Copy output to file for reference.
exec > >(tee -i venv-logfile-`date +'%Y%m%d-%H%M%S'`.txt)
exec 2>&1

module purge
module load python37
module list

export root=`pwd`
unset PYTHONPATH
export PIP_NO_CACHE_DIR=off
export ENVNAME=venv-torch1121
export ENVPATH=$root/${ENVNAME}-macs

python3 -m venv --prompt $ENVNAME --clear $ENVPATH

$ENVPATH/bin/pip install --upgrade pip
$ENVPATH/bin/pip --version
$ENVPATH/bin/pip3 install \
    --extra-index-url https://download.pytorch.org/whl/cu113 \
    -r requirements.txt
