FROM ubuntu:14.04.5

RUN apt-get update \
        && apt-get install -y apache2 curl git default-jdk gradle \
        && git clone https://sriman-biarca:vedams123@github.com/sriman-biarca/hello-karyon-rxnetty.git \
        && cd hello-karyon-rxnetty \
        && ./gradlew clean packDeb
        
ADD build/libs/hello-karyon-rxnetty-all-0.1.0.jar /home/biarca/biarca-pool-all.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/home/biarca/biarca-pool-all.jar"]
