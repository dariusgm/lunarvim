# docker login -u dariusmurawski
# docker build -t dariusmurawski/lunarvim:latest .
# docker push dariusmurawski/lunarvim:latest
# docker run -v .:/repo -it dariusmurawski/lunarvim:latest bash
FROM ubuntu:latest AS base
RUN apt-get update -y && apt upgrade -y && apt-get install -y curl git make nodejs npm build-essential gcc


FROM base AS lazygit
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xf lazygit.tar.gz lazygit && \
    install lazygit /usr/local/bin && \
    rm lazygit.tar.gz



FROM base AS python
# python
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN apt-get update -y
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git
RUN rm -rf ~/.pyenv
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN pyenv install --list | grep -v - | grep -v b | grep -v miniforge | grep -v rc | grep -v '2.' | tail -n 1 | awk -F'[[:space:]]' '{print $NF}' > long.txt
RUN cat long.txt | awk -F'[[:space:]]' '{print $NF}' | awk -F'\.' '{print $1"."$2}' > short.txt
RUN pyenv install $(cat long.txt)
RUN pyenv global $(cat long.txt)
RUN pyenv rehash
RUN ~/.pyenv/versions/$(cat long.txt)/bin/python$(cat short.txt) -m pip install --upgrade pip
RUN ~/.pyenv/versions/$(cat long.txt)/bin/python$(cat short.txt) -m pip install pynvim

FROM base AS rust
RUN curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs | sh -s -- -y && \
  apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install --reinstall ca-certificates && \
  update-ca-certificates
ENV PATH="/root/.cargo/bin:$PATH"
RUN cargo install fd-find && cargo install ripgrep

FROM base AS neovim
RUN apt-get install -y ninja-build gettext cmake unzip curl git file
RUN npm install -g neovim
#    node-tree-sitter  \
#    tree-sitter-bash  \
#    tree-sitter-cli \
#    tree-sitter-css  \
#    tree-sitter-html  \
#    tree-sitter-javascript  \
#    tree-sitter-json  \
#    tree-sitter-python \
#    tree-sitter-regex  \
#    tree-sitter-rust  \
#    tree-sitter-toml  \
#    tree-sitter-yaml
RUN git clone --depth 1 --branch stable https://github.com/neovim/neovim ~/neovim && \
  cd ~/neovim && \
  make CMAKE_BUILD_TYPE=RelWithDebInfo && \
  cd build && cpack -G DEB && dpkg -i nvim-linux64.deb && rm -rf ~/neovim

FROM base AS powershell7
# Install pre-requisite packages.
RUN apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
RUN wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
# Register the Microsoft repository GPG keys and Delete the the Microsoft repository GPG keys file
RUN dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
RUN apt-get update -y
# Install PowerShell
RUN apt-get install -y powershell

FROM base AS aws
# install aws
RUN npm install -g aws-cdk && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    mkdir -p ~/.aws && \
    rm awscliv2.zip && \
    rm -rf aws

# install terraform
FROM base AS terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg |  gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" |  tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update -y && apt-get install terraform

# install lunarvim
FROM base AS lunarvim
# COPY --from=neovim /
RUN curl -s -L -k -o ~/lunarvim-install.sh https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh
RUN LV_BRANCH='release-1.3/neovim-0.9' bash ~/lunarvim-install.sh -y
ENV PATH="/root/.local/bin:$PATH"
## update plugins
RUN lvim +PackerSync +q
## install config
RUN echo "vim.opt.timeoutlen = 100" >> /root/.config/lvim/config.lua
#
## install font on your client
## curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip -o UbuntuMono.zip
