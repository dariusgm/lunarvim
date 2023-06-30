# lunarvim

This image provide a full lunarvim based IDE.

## build

```shell
docker build --pull --progress=plain -t dariusmurawski/lunarvim:latest .
```

## Release

```shell
docker login -u dariusmurawski
docker push dariusmurawski/lunarvim:latest
```

## Use (Linux)

```shell
docker run -v $PWD:/repo -it dariusmurawski/lunarvim:latest bash
```

## Use (Windows)

```shell
docker run -v .:/repo -it dariusmurawski/lunarvim:latest bash
```
 
