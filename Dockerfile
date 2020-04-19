FROM adoptopenjdk/openjdk8:alpine

ENV CLJ_TOOLS_VERSION=1.10.1.536

RUN apk add bash curl git maven

#--- Clojure-Tools
# https://clojure.org/guides/getting_started#_installation_on_linux
RUN curl -O https://download.clojure.org/install/linux-install-${CLJ_TOOLS_VERSION}.sh \
 && chmod +x linux-install-${CLJ_TOOLS_VERSION}.sh \
 && ./linux-install-${CLJ_TOOLS_VERSION}.sh \
 && clojure -e '(println "IT WORKS!")'

ENV USER=cljog

RUN addgroup -g 1000 -S "$USER" && \
    adduser -u 1000 -S "$USER" -G "$USER"

RUN git clone https://github.com/sstephenson/bats.git && cd bats && ./install.sh /usr/local

USER cljog
WORKDIR "/home/$USER"
RUN echo 'export PATH="$HOME/bin:$PATH"' > "/home/$USER/.bashrc"
RUN mkdir bin
CMD ["bash"]
