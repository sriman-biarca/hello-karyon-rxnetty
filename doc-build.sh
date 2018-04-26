#!/bin/bash
set -e

#docker build -t hello-code .
#docker images
#docker tag hello-code gcr.io/my-project/my-image:test
#gcloud docker push gcr.io/my-project/my-image

docker build -t gcr.io/spinnaker-terraform/hello-code:test .

if [ ! -d "$HOME/google-cloud-sdk/bin" ]; then rm -rf $HOME/google-cloud-sdk; export CLOUDSDK_CORE_DISABLE_PROMPTS=1; curl https://sdk.cloud.google.com | bash; fi

source /home/travis/google-cloud-sdk/path.bash.inc

gcloud --quiet version

echo $GCLOUD_SERVICE_KEY_PRD | base64 --decode -i > $HOME/spin-terra.json

echo $GCLOUD_SERVICE_KEY_PRD

cat $HOME/spin-terra.json

gcloud auth activate-service-account --key-file=$HOME/spin-terra.json

gcloud --quiet config set project spinnaker-terraform
gcloud docker push gcr.io/spinnaker-terraform/hello-code
