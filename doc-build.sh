#!/bin/bash
set -e

#docker build -t hello-code .
#docker images
#docker tag hello-code gcr.io/my-project/my-image:test
#gcloud docker push gcr.io/my-project/my-image

docker build -t gcr.io/spinnaker-terraform/hello-code:test .

echo $GCLOUD_SERVICE_KEY_PRD | base64 --decode -i > $HOME/spin-terra.json
gcloud auth activate-service-account --key-file $HOME/spin-terra.json

gcloud --quiet config set project spinnaker-terraform

gcloud docker push gcr.io/spinnaker-terraform/hello-code
