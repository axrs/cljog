#!/usr/bin/env bash

apk add curl

CLJ_TOOLS_VERSION=1.10.1.492

curl -O https://download.clojure.org/install/linux-install-${CLJ_TOOLS_VERSION}.sh \
 && chmod +x linux-install-${CLJ_TOOLS_VERSION}.sh \
 && ./linux-install-${CLJ_TOOLS_VERSION}.sh
