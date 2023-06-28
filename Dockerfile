# docker build -t dariusmurawski/lunarvim:latest .
# docker login -u dariusmurawski
# docker push dariusmurawski/lunarvim:latest
# docker run -v $PWD:/repo -it dariusmurawski/lunarvim:latest bash
FROM ubuntu:latest AS base
RUN apt-get update -y && apt upgrade -y && apt-get install -y curl git make nodejs npm build-essential gcc


FROM base AS lazygit
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xf lazygit.tar.gz lazygit && \
    install lazygit /usr/local/bin && \
    rm lazygit.tar.gz



# python
FROM python:3.11 AS python
# python
RUN python -m pip install --upgrade pip
RUN python -m pip install pynvim


FROM base AS rust
RUN curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs | sh -s -- -y && \
  apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install --reinstall ca-certificates && \
  update-ca-certificates
RUN /root/.cargo/bin/cargo install fd-find & /root/.cargo/bin/cargo install ripgrep & wait && \
    /root/.cargo/bin/rustup default stable


# for parsers
FROM base AS node
RUN npm install -g  \
    neovim \
    tree-sitter-bash  \
    tree-sitter-cli \
    tree-sitter-css  \
    https://github.com/camdencheek/tree-sitter-dockerfile \
    tree-sitter-html  \
    tree-sitter-javascript  \
    tree-sitter-json  \
    https://github.com/PowerShell/tree-sitter-PowerShell \
    tree-sitter-python \
    tree-sitter-regex  \
    tree-sitter-rust \
    tree-sitter-toml  \
    tree-sitter-yaml

FROM base AS powershell7
RUN apt-get install -y wget apt-transport-https software-properties-common && \
   wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" && \
   dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb && \
   apt-get update -y && \
   apt-get install -y powershell

# install aws
FROM base AS aws
RUN apt-get install -y unzip && \
npm install -g aws-cdk && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -qq awscliv2.zip && \
    ./aws/install && \
    mkdir -p ~/.aws && \
    rm awscliv2.zip && \
    rm -rf aws


# install neovim and lunarvim
FROM base
COPY --from=lazygit /usr/local/bin /usr/local/bin
COPY --from=python /usr/local /usr/local
COPY --from=rust /root/.cargo/bin /root/.cargo/bin
ENV PATH="/root/.cargo/bin:$PATH"
COPY --from=powershell7 /usr/bin /usr/bin

COPY --from=aws /usr/local/bin /usr/local/bin

COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin /usr/local/bin

# neovim and lunarvim
ARG LV_BRANCH=release-1.3/neovim-0.9
RUN  curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install-neovim-from-release | bash && \
     curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install.sh | bash -s -- --no-install-dependencies
ENV PATH="/root/.local/bin:$PATH"
## install config
RUN echo "vim.opt.timeoutlen = 100" >> /root/.config/lvim/config.lua

## update plugins
# RUN lvim :MasonUpdate
#
## install font on your client
## curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip -o UbuntuMono.zip
