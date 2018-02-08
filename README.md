# Concourse CI with Docker Compose

Upstream instructions on how to bring up a Concourse environment with Docker
Compose live at http://www.concourse.ci/docker-repository.html. This repo
makes those instructions easier to consume.

The *fly* directory contains a Dockerfile to build an image with ``fly``
installed.

# Requirements

* Docker
* Python 3.6+
* [pipenv](https://docs.pipenv.org/)
* GNU make
* ssh-keygen

# Initial Setup

        $ make init

# Environment Lifecycle

``docker-compose`` is used to manage the lifecycle of Concourse containers.
Helper targets in ``make`` are *up*, *down*, and *ps* based on their
counterparts *up -d*, *down*, and *ps* respectively in ``docker-compose``.

        $ make up
        $ make ps
        $ make down

A helper target to build the ``fly`` Docker image is *build*.

        $ make build

Run ``fly`` cli in its container.

        $ make exec
        # fly

Get a list of all ``make`` targets.

        $ make list

## Caution

Cleaning up the environment is synonymous with *down*.

        $ make clean

## Alert

Destroying the environment cleans it first then removes keys and PostgreSQL
data.

        $ make destroy

Run the *init* target to go back to a usable state.

        $ make init

# Customize

These files are prime candidates to customize for your needs.

## .envrc

Modify ``fly`` version and other authentication credentials to your liking.

I've made a best-effort guess of which host IP to use for the
*CONCOURSE_EXTERNAL_URL* environment variable. Modify it as needed.

## docker-compose.yml

May not require too much attention but you never know.

## Makefile

May not require too much attention but you never know.

## fly/Dockerfile

Contains examples for Ubuntu 16.04 and Alpine 3.7. By default, uses Ubuntu
16.04.
