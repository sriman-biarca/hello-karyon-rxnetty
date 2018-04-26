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


gcloud auth activate-service-account --key-file=$HOME/spin-terra.json

gcloud --quiet config set project spinnaker-terraform

VERSION=1.4.3
OS=linux  # or "darwin" for OSX, "windows" for Windows.
ARCH=amd64  # or "386" for 32-bit OSs

curl -L "https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${VERSION}/docker-credential-gcr_${OS}_${ARCH}-${VERSION}.tar.gz" \
  | tar xz --to-stdout docker-credential-gcr \
  > /usr/bin/docker-credential-gcr && chmod +x /usr/bin/docker-credential-gcr

export CLOUDSDK_CORE_DISABLE_PROMPTS=1
gcloud components install docker-credential-gcr
docker-credential-gcr configure-docker

#gcloud docker -- push gcr.io/spinnaker-terraform/hello-code


docker tag hello-code gcr.io/spinnaker-terraform/hello-code:test
docker push gcr.io/spinnaker-terraform/hello-code
