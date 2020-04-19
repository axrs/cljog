FROM adoptopenjdk/openjdk8:alpine

ENV CLJ_TOOLS_VERSION=1.10.1.536 \
    LEIN_INSTALL=/usr/local/bin/ \
    LEIN_VERSION=2.9.2

RUN apk add bash curl git maven column

#--- Clojure-Tools
# https://clojure.org/guides/getting_started#_installation_on_linux
RUN curl -O https://download.clojure.org/install/linux-install-${CLJ_TOOLS_VERSION}.sh \
 && chmod +x linux-install-${CLJ_TOOLS_VERSION}.sh \
 && ./linux-install-${CLJ_TOOLS_VERSION}.sh \
 && clojure -e '(println "IT WORKS!")'

 #--- Leiningen
 # https://hub.docker.com/_/clojure
 # https://github.com/Quantisan/docker-clojure/blob/master/target/openjdk-8-stretch/lein/Dockerfile
 RUN mkdir -p $LEIN_INSTALL \
  && wget -q https://raw.githubusercontent.com/technomancy/leiningen/$LEIN_VERSION/bin/lein-pkg \
  && echo 'Comparing lein-pkg checksum ...' \
  && sha256sum lein-pkg \
  && echo '36f879a26442648ec31cfa990487cbd337a5ff3b374433a6e5bf393d06597602 *lein-pkg' | sha256sum -c - \
  && mv lein-pkg $LEIN_INSTALL/lein \
  && chmod 0755 $LEIN_INSTALL/lein \
  && wget -q https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip \
  && mkdir -p /usr/share/java \
  && mv leiningen-$LEIN_VERSION-standalone.zip /usr/share/java/leiningen-$LEIN_VERSION-standalone.jar

ENV USER=cljog

RUN addgroup -g 1000 -S "$USER" && \
    adduser -u 1000 -S "$USER" -G "$USER"

RUN git clone https://github.com/sstephenson/bats.git && cd bats && ./install.sh /usr/local

USER cljog
WORKDIR "/home/$USER"
RUN echo 'export PATH="$HOME/bin:$PATH"' > "/home/$USER/.bashrc"
RUN mkdir bin
CMD ["bash"]
