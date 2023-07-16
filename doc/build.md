This document describe how to build the entire image stack.
Note that this is mainly a documentation for myself...


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


