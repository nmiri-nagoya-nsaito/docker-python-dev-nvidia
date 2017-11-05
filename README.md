# docker-python-dev
a docker project for python development environment based on ubuntu (xenial)

## How to use
1. build image

    ```
    docker-compose build
    ```
    If the image is already built and exists, add a "--no-cache" flag to command line.
    
    ```
    docker-compose build --no-cache
    ```

1. start a new (or the existing) container and enter a bash shell in the container (I assume that your current directory is 
"\<somewhere\>/docker-python-dev".)

    ```
    ./start_shell.sh
    ```

1. exit from the container 

    ```
    # enter this command in the bash shell
    exit
    ```

1. stop container (but the container is not deleted)

    ```
    docker-compose stop
    ```

1. stop container (and the container is deleted)

    ```
    docker-compose down
    ```

1. list the container in conjunction with this directory

    ```
    docker-compose ps
    ```

## Create a configuration file

Because Ctrl-P is assigned for a part of detach operation, when working with shell, it is necessary to create the file ```~/.docker/config.json``` with the following contents:

```
{
	"detachKeys": "ctrl-\\"
}
```
In the above example, "ctrl-\\" can be replaced with other keys as you like.
