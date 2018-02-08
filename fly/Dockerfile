FROM ubuntu:16.04

ARG FLY_CLI_VERSION

ENV FLY_CLI_VERSION=${FLY_CLI_VERSION} \
    CONCOURSE_EXTERNAL_URL=NOTSET \
    CONCOURSE_BASIC_AUTH_USERNAME=NOTSET \
    CONCOURSE_BASIC_AUTH_PASSWORD=NOTSET

RUN    apt update && apt install -y bash curl git unzip vim zip \
    && curl -L -o /usr/local/bin/fly_linux_amd64_${FLY_CLI_VERSION} https://github.com/concourse/concourse/releases/download/v${FLY_CLI_VERSION}/fly_linux_amd64 \
    && ln -s /usr/local/bin/fly_linux_amd64_${FLY_CLI_VERSION} /usr/local/bin/fly \
    && chmod +x /usr/local/bin/fly*


# FROM alpine:3.7

# ARG FLY_CLI_VERSION

# ENV FLY_CLI_VERSION=${FLY_CLI_VERSION} CONCOURSE_EXTERNAL_URL=NOTSET CONCOURSE_BASIC_AUTH_USERNAME=NOTSET CONCOURSE_BASIC_AUTH_PASSWORD=NOTSET

# RUN    apk update && apk add --no-cache bash curl git unzip vim zip \
#     && curl -L -o /usr/local/bin/fly_linux_amd64_${FLY_CLI_VERSION} https://github.com/concourse/concourse/releases/download/v${FLY_CLI_VERSION}/fly_linux_amd64 \
#     && ln -s /usr/local/bin/fly_linux_amd64_${FLY_CLI_VERSION} /usr/local/bin/fly \
#     && chmod +x /usr/local/bin/fly*
