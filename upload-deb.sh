#!/bin/bash
echo Uploading artifact: http://dummy/repo/hello-karyon-rxnetty_1-1_all.deb

#nohup ./aptly api serve &

#curl -F file=@build/distributions/hello-karyon-rxnetty_1-1_all.deb http://aptly-ip:8080/api/files/karyon
#curl -X DELETE http://aptly-ip:8080/api/files/hello-karyon-rxnetty
#curl -X POST http://aptly-ip:8080/api/repos/my-karyon-rxnetty/file/karyon
#curl -X PUT -H 'Content-Type: application/json' --data '{"Distribution": "trusty", "ForceOverwrite": true, "Architectures":["amd64"], "Signing": {"Skip": true}, "SourceKind": "local", "Sources": [{"Name":"my-karyon-rxnetty"}]}' http://aptly-ip:8080/api/publish/:./trusty

curl -X DELETE http://aptly-ip:8080/api/files/hello-karyon-rxnetty
curl -X DELETE http://aptly-ip:8080/api/publish//trusty
curl -X DELETE http://aptly-ip:8080/api/repos/hello-karyon-rxnetty
curl -F file=@build/distributions/hello-karyon-rxnetty_1-1_all.deb http://aptly-ip:8080/api/files/hello-karyon-rxnetty
curl -X POST -H 'Content-Type: application/json' --data '{"Name": "hello-karyon-rxnetty"}' http://aptly-ip:8080/api/repos
curl -X POST http://aptly-ip:8080/api/repos/hello-karyon-rxnetty/file/hello-karyon-rxnetty
curl -X POST -H 'Content-Type: application/json' --data '{"Distribution": "trusty", "Architectures":["amd64"], "Signing": {"Skip": true}, "SourceKind": "local", "Sources": [{"Name":"hello-karyon-rxnetty"}]}' http://aptly-ip:8080/api/publish
