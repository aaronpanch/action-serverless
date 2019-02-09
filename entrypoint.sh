#!/bin/sh
set -e

ROOT=${SERVICE_ROOT:-.}

cd $ROOT
serverless $*
