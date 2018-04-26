FROM openjdk:8-jre
RUN useradd --home-dir /home/biarca --create-home -U biarca
RUN ./gradlew clean packDeb
USER biarca
RUN cd /home/biarca/; mkdir -p .biarca
ADD build/libs/hello-karyon-rxnetty-all-0.1.0.jar /home/biarca/biarca-pool-all.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/home/biarca/biarca-pool-all.jar"]
