#!/bin/bash

# exit if a command returns a non-zero exit code and also print the commands and their args as they are executed.
set -e -x

# Download and install required tools.
# pulumi
curl -L https://get.pulumi.com/ | bash
export PATH=$PATH:$HOME/.pulumi/bin
apt-get update
apt-get install python3.8-venv -y 

# Restore npm dependencies for our infra app.
yarn install

# Login into pulumi. This will require the PULUMI_ACCESS_TOKEN environment variable.
pulumi login

# Select the appropriate stack.
pulumi stack select smitasulikal/gcp-py-functions/dev
apt-get update 
python3.8 -m venv myvenv 

case $BUILD_TYPE in
  PullRequest)
      pulumi preview
    ;;
  *)
      pulumi up --yes
    ;;
esac
