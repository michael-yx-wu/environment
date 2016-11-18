#!/usr/bin/env bash

brew install bash-completion
curl -L "https://raw.githubusercontent.com/docker/docker/v$(docker version --format '{{.Client.Version}}')/contrib/completion/bash/docker" > /usr/local/etc/bash_completion.d/docker
curl -L "https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose" > /usr/local/etc/bash_completion.d/docker-compose
