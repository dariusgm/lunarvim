# LunarVim Docker Image

The LunarVim Docker image provides a full-fledged Integrated Development Environment (IDE) based on LunarVim. This image is designed to cater to developers by pre-installing all necessary tools and languages, allowing you to start coding immediately after pulling the image.

## Use (Linux)

```shell
docker run -it -v $PWD:/repositories -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/root/.gitconfig -it dariusmurawski/lunarvim:latest
```

## Use (Windows)

```powershell
docker run -it -v .:/repositories -v $HOME\.ssh:/root/.ssh -v $HOME\.gitconfig:/root/.gitconfig  dariusmurawski/lunarvim:latest
```
## Features

The LunarVim Docker image comes with:

- A pre-installed LunarVim installation with support for various languages.
- The latest available software versions for your usage.
- A `lazygit` client for easy git operations.
- Pre-installed language environments and tools including Amazon Web Services CLI, Node, Python, and Rust.
- Other helpful tools like `ripgrep`, `fd-find`, `code-minimap`, GitHub Copilot, and ChatGPT integration.


## Configuration
The leaderkey is defined as ´space´.

## lazygit
Lazygit is the in-built git client accessible from LunarVim using the `space g g` key combination. It can also be launched directly within your repository by calling `lazygit`.

| Key/Key Combination |        Action       |
|:-------------------:|:-------------------:|
|        `p`          |      git pull       |
|        `P`          |      git push       |
|        `c`          |    git commit       |
|        `:`          | Execute command     |

The list of supported shortcuts can be viewed by pressing `?`, or visit the [Lazygit Repository](https://github.com/jesseduffield/lazygit/) for more information.


### Languages and Tools

The Docker image is pre-loaded with the following languages and tools:

#### Amazon Web Services 

The aws-cli and the aws-sdk Node package are pre-installed. AWS secrets generated outside Docker can be mounted as follows:

```bash
docker run -it -v /your/home/.aws:/root/.aws dariusmurawski/lunarvim
```

### Node
Node 20 and npm 9.5 are pre-installed. Certain Treesitter plugins and the aws-sdk require Node packages.

### Powershell7
This is currently removed and will be adressed soon. 

### Python
Python 3.11 and pip 23.1 are preinstalled. 
Some Treesitter plugins require pip packages.

### Rust

LunarVim has Rust dependencies, hence Rust is pre-installed. 
The image includes `rustc`, `compiler`, `cargo`, `clippy`, 
and other tools from the Rust toolchain. 
The stable Rust toolchain is used.

### Additinal Tools

* ripgrep: for fast searching in files.
* fd-find: for quick file searching.
* code-minimap: provides a minimap of the code.

### github copilot
The github copiot is also available.
Use `:Copilot auth`  to create an token.
To use the suggestions, open the panel using:
`:Copilot suggestions`

#### secret
To not log in after quitting the container, you can save the generated token via a mount:
~/.config/github-copilot/


### ChatGPT
The ChatGPT integration is also available.
Provide the OPENAI_API_KEY as enviroment variable to the container.


```bash
docker run -it -e OPENAI_API_KEY=$OPENAI_API_KEY dariusmurawski/lunarvim
```

You can access the Plugin via `:ChatGPT` command.

# Usage

Before using the image, ensure that you've added the necessary credentials 
via volume mounts for services like git that require them.


```bash
docker run -it -v $PWD:/repositories -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/root/.gitconfig -it dariusmurawski/lunarvim:latest
```

# Customize
You can customize the image to suit your own or your company's needs by adding other secrets to access mirrors or other CLI tools that you need.

```docker
FROM dariusmurawski/lunarvim:latest
RUN apt-get install -y <your dependency>
```

The image is based on ubuntu 22.04 (Jemmy Jellyfish).
You can also use parts of the stack for your own use case.

# FAQ
## How to mount repositories?  
Please mount your repositories under repositories.
This will allow the Docker image to automatically index all your repos so you can work with them. 

```bash
docker run -it -v /your/home/repositories:/repositories dariusmurawski/lunarvim
```


## How to mount SSH Keys? 
To access your repositories and provide pull/push access for `lazygit` or `git`, you can mount your private SSH keys.
```bash
docker run -it -v /your/home/.ssh:/root/.ssh dariusmurawski/lunarvim
```
Similarly, you can provide the git configuration via mounting it:

```bash
docker run -it -v /your/home/.gitconfig:/root/.gitconfig
```


## Additinal Installed Plugins
The LunarVim Docker image includes several pre-installed plugins to enhance your coding experience. Please refer to the respective sections above for more details.

* LSP: Language Server Protocol - autocomplete.
* DAP: Debug Adapter Protocol - for debugging. 
* Linter: Checks if the code is formatting according to style guides.
* Formatter: Formats code according to a style guide.

### LSP
* awk-language-server awk_ls
* bash-language-server bashls
* css-lsp cssls
* diagnostic-languageserver diagnosticls
* dockerfile-language-server dockerls
* dot-language-server dotls
* gradle-language-server gradle_ls
* grammarly-languageserver grammarly
* graphql-language-service-cli graphql
* html-lsp html
* json-lsp jsonls
* lua-language-server lua_ls
* marksman 
* powershell-editor-services powershell_es
* pyright 
* python-lsp-server pylsp
* rust-analyzer rust_analyzer
* spectral-language-server spectral
* sqlls 
* svelte-language-server svelte
* tailwindcss-language-server tailwindcss
* terraform-ls terraformls
* tflint 
* typescript-language-server tsserver
* unocss-language-server unocss
* vetur-vls vuels
* vim-language-server vimls

## DAP
* bash-debug-adapter
* debugpy

## Linter
* ansible-lint
* curlylint
* flake8
* jsonlint
* markdownlint
* tflint
* yamllint

## Formatter
* black
* jq
* markdownlint
* rustfmt
* yamlfmt


 
