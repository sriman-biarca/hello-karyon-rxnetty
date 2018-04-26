FROM ubuntu:14.04.5

RUN apt-get update \
        && apt-get install -y apache2 curl git \
        && git clone https://sriman-biarca:vedams123@github.com/sriman-biarca/hello-karyon-rxnetty.git \
        && apt-get install -y software-properties-common debconf-utils \
        && add-apt-repository -y ppa:webupd8team/java \
        && apt-get update \
        && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections \
        && apt-get install -y oracle-java8-installer gradle \
        && cd hello-karyon-rxnetty \
        && ./gradlew clean packDeb \
        && cp build/libs/hello-karyon-rxnetty-all-0.1.0.jar /biarca-pool-all.jar
        
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/biarca-pool-all.jar"]
