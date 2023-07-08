FROM dariusmurawski/lunarvim_lazygit:latest AS lazygit
FROM dariusmurawski/lunarvim_python:latest AS python
FROM dariusmurawski/lunarvim_powershell7:latest AS powershell7
FROM dariusmurawski/lunarvim_aws:latest AS aws
FROM dariusmurawski/lunarvim_node:latest AS node
FROM dariusmurawski/lunarvim_rust:latest AS rust

# install neovim and lunarvim
FROM dariusmurawski/lunarvim_base:latest
COPY --from=lazygit /usr/local/bin /usr/local/bin
COPY --from=python /usr/local /usr/local
COPY --from=powershell7 /usr/bin /usr/bin

COPY --from=aws /usr/local/bin /usr/local/bin

COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=rust /usr/local/cargo/bin /usr/local/cargo/bin
ENV PATH="/root/.cargo/bin:$PATH"

# neovim and lunarvim
ARG LV_BRANCH=release-1.3/neovim-0.9
RUN  curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install-neovim-from-release | bash && \
     curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install.sh | bash -s -- --no-install-dependencies
ENV PATH="/root/.local/bin:$PATH"
## install config

## install plugins
COPY config.lua /root/.config/lvim/config.lua
RUN lvim --headless +qall

## install font on your client
# curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip -o UbuntuMono.zip
