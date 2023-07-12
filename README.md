# lunarvim

This image provide a full lunarvim based IDE.

```shell
docker login -u dariusmurawski
```

## build base

```shell
docker build --pull --progress=plain -t dariusmurawski/lunarvim_base:latest base
docker push dariusmurawski/lunarvim_base:latest
```

## build aws

```shell
docker build --pull --progress=plain -t dariusmurawski/lunarvim_aws:latest aws
docker push dariusmurawski/lunarvim_aws:latest
```

## build lazygit

```shell
docker build --pull --progress=plain -t dariusmurawski/lunarvim_lazygit:latest lazygit
docker push dariusmurawski/lunarvim_lazygit:latest
```

## build node

```shell
docker build --pull --progress=plain -t dariusmurawski/lunarvim_node:latest node
docker push dariusmurawski/lunarvim_node:latest
```

## build powershell7

```shell
docker build --pull --progress=plain -t dariusmurawski/lunarvim_powershell7:latest powershell7
docker push dariusmurawski/lunarvim_powershell7:latest
```

## build python

```shell
docker build --pull --progress=plain -t dariusmurawski/lunarvim_python:latest python
docker push dariusmurawski/lunarvim_python:latest
```

## build rust

```shell
docker build --pull --progress=plain -t dariusmurawski/lunarvim_rust:latest rust
docker push dariusmurawski/lunarvim_rust:latest
```

## Release

```shell
docker build --pull --progress=plain -t dariusmurawski/lunarvim:latest .
docker push dariusmurawski/lunarvim:latest
```

# Use
Before you can use the image, make sure to add additial credentials via volume,
so you can work with git and other services, that require credentials.

Run the image of the root directory, where all your repositories are that you want to work with.
The start.sh script will check at boottime the permissions of the private keys
and update them accordingly (using chmod 400).

## Use (Linux)

```shell
docker run -v $PWD:/repositories -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/root/.gitconfig -it dariusmurawski/lunarvim:latest bash
```

## Use (Windows)

```shell
docker run -it -v .:/repo -v $HOME\.ssh:/root/.ssh -v $HOME\.gitconfig:/root/.gitconfig  lunarvim:latest bash
chmod 400 -R /root/.ssh && lvim /repo
```
 
