# lunarvim

This image provide a full lunarvim based IDE.
The main target is to have everything pre-installed
that you need as a developer.
Only pull the image and start working on the supported languages.

# What is inside?

In the final image, you have a preinstalled lunarvim installation,
where the supported languages are also part of the image.
It also uses latest available software that you can use.

## Configuration
The leaderkey is defined as ´space´.

## Software
### lazygit
`lazygit` is the pre-installed git client that you can access 
from lunarvim using the `space g g` key combination.

You can also launch is via calling `lazygit` directly, inside
your repository.

#### KeyBindings

| Key/Key Combination |        Action       |
|:-------------------:|:-------------------:|
|        `p`          |      git pull       |
|        `P`          |      git push       |
|        `c`          |    git commit       |
|        `:`          | Execute command     |

You can open the list of supported shortcuts with `?`, or check the 
[Lazygit Repository](https://github.com/jesseduffield/lazygit/).


## Languages / Tools
Here is a overview on the languages and tools that are directly available.
### Amazon Web Services 
The aws-cli and the aws-sdk node package is preinstalled.

#### Mounting Secrets
When you generate the secres outside docker, you can mount them:


```bash
docker run -it -v /your/home/.aws:/root/.aws dariusmurawski/lunarvim
```

### Node
Node 20 and npm 9.5 are preinstalled.
Some Treesitter plugins (and aws sdk) require node packages.

# FAQ

## Customize
You can customize the image with your own (company) needs
for example, adding other secrets to access pypi mirrors or
other cli tools that you need.

Simply use the Docker `FROM` clouse:
```docker
FROM dariusmurawski/lunarvim:latest
RUN apt-get install -y <your dependency>
```

The image is based on ubuntu 22.04 (Jemmy Jellyfish).

You can also use parts of the stack for your own use case.


## Mounting repositories
Please mount your repositories under `repositories`.
This will allow the docker image to automaticly index all your repos,
so you can work with them.

```bash
docker run -it -v /your/home/repositories:/repositories dariusmurawski/lunarvim
```


## git
### Mounting ssh keys
To access your repositories and provide pull / push access for lazygit,
you can mount your private ssh keys.

```bash
docker run -it -v /your/home/.ssh:/root/.ssh dariusmurawski/lunarvim
```

In the same way you can provide the git configuration via mounting it:

```bash
docker run -it -v /your/home/.gitconfig:/root/.gitconfig
```


# Supported Languages

This contains a list of supported languages as of this writing.
It may get extended by you, by provided a pull request :-)

## Additinal Installed Plugins

### github copilot

# Customize for enterprise use

# Use
Before you can use the image, make sure to add additial credentials via volume,
so you can work with git and other services, that require credentials.

Run the image of the root directory, where all your repositories are that you want to work with.
A script will check the settings (mounts) that you provide and launch lunarvim.
Make sure to only overwrite the command of the container for debugging.

## Use (Linux)

```shell
docker run -it -v $PWD:/repositories -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/root/.gitconfig -it dariusmurawski/lunarvim:latest
```

## Use (Windows)

```shell
docker run -it -v .:/repositories -v $HOME\.ssh:/root/.ssh -v $HOME\.gitconfig:/root/.gitconfig  dariusmurawski/lunarvim:latest
```
 
