## Build process setup

Sections `Prerequisites` and `Setup` should be done only once per build host

### Requirements

* Docker CE 20.10.0+ (https://docs.docker.com/desktop/setup/install/linux/)

### PHP 8.3 Requirements

### Prerequisites

1. `Docker` should be installed on build host following these instructions:

    https://docs.docker.com/engine/install/

3. Add your build user into docker group (required to manage docker):

    ```
    usermod -aG docker <username>
    ```

    and relogin

4. Start Docker daemon

    ```
    systemctl enable docker
    systemctl start docker
    ```

### Setup

1. Clone build repo with submodules:

    ```
    git clone --recursive https://github.com/aursu/rpmbuild-php-8.3.git
    cd rpmbuild-php-8.3
    ```

### Build process


1. Build images

    ```
    docker compose -f docker-compose.base.yml build
    docker compose build
    ```

2. Build packages

    ```
    docker compose up -d
    ```

    command above will start all build services in background. But it is possible
to run any of them or run in foreground etc

3. Wait until command `docker-compose ps` returns all services in state 'Exit 0'

### Access RPM packages

1. RPM packages located inside `rpm9rocky` and `rpm10rocky` volumes

### Clean up build

To complete all build processes run commands:

```
docker compose down
```

These commands will stop and remove all containers but not build images (see
`docker images` and `docker rmi` commands manuals)
