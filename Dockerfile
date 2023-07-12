FROM dariusmurawski/lunarvim_lazygit:latest AS lazygit
FROM dariusmurawski/lunarvim_python:latest AS python
FROM dariusmurawski/lunarvim_powershell7:latest AS powershell7
FROM dariusmurawski/lunarvim_aws:latest AS aws
FROM dariusmurawski/lunarvim_node:latest AS node
FROM dariusmurawski/lunarvim_rust:latest AS rust

# install neovim and lunarvim
FROM dariusmurawski/lunarvim_base:latest
COPY --from=lazygit /usr/local/bin /usr/local/bin
COPY --from=lazygit /root/.config/ /root/.config/

COPY --from=python /usr/local /usr/local
# COPY --from=powershell7 /usr/bin /usr/bin

COPY --from=aws /usr/local/bin /usr/local/bin
COPY --from=aws /usr/local/aws-cli/ /usr/local/aws-cli/

COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin /usr/local/bin

COPY --from=rust /usr/local/cargo/bin /usr/local/cargo/bin
COPY --from=rust /usr/local/rustup /usr/local/rustup
ENV PATH="/root/.cargo/bin:/usr/local/cargo/bin:/usr/local/rustup:$PATH"
ENV CARGO_HOME=/usr/local/cargo
ENV RUSTUP_HOME=/usr/local/rustup
# neovim and lunarvim
ARG LV_BRANCH=release-1.3/neovim-0.9
RUN  curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install-neovim-from-release | bash && \
     curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install.sh | bash -s -- --no-install-dependencies
ENV PATH="/root/.local/bin:$PATH"
## core update to trigger first boot
RUN lvim +LvimUpdate +qall
COPY config.lua /root/.config/lvim/config.lua
RUN lvim --headless +LvimReload +qall
RUN lvim --headless +'Lazy sync' +qall
# LSP
RUN lvim --headless +'MasonInstall ansible-language-server' +qall
RUN lvim --headless +'MasonInstall cmake-language-server' +qall
RUN lvim --headless +'MasonInstall css-lsp' +qall
RUN lvim --headless +'MasonInstall docker-compose-language-service' +qall
RUN lvim --headless +'MasonInstall dockerfile-language-server' +qall
RUN lvim --headless +'MasonInstall html-lsp' +qall
RUN lvim --headless +'MasonInstall python-lsp-server' +qall
RUN lvim --headless +'MasonInstall lua-language-server' +qall

# toml
RUN lvim --headless +'MasonInstall taplo' +qall
RUN lvim --headless +'MasonInstall terraform-ls' +qall
RUN lvim --headless +'MasonInstall tflint' +qall
# DAP
RUN lvim --headless +'MasonInstall bash-debug-adapter' +qall
# DAP Python
RUN lvim --headless +'MasonInstall debugpy' +qall
# Linter
RUN lvim --headless +'MasonInstall tflint yamllint markdownlint jsonlint flake8 curlylint ansible-lint' +qall
# Formatter
# RUN lvim --headless +'MasonInstall htmlbeautifier' +qall
# rust
RUN lvim --headless +'MasonInstall rustfmt' +qall
# yaml / yml
RUN lvim --headless +'MasonInstall yamlfmt' +qall
# jq
RUN lvim --headless +'MasonInstall jq' +qall
# python
RUN lvim --headless +'MasonInstall black' +qall
# Treesitter
RUN lvim --headless +'TSInstallSync lua' +qall
RUN lvim --headless +'TSInstallSync query' +qall
RUN lvim --headless +'TSInstallSync markdown_inline' +qall
RUN lvim --headless +'TSInstallSync comment' +qall
RUN lvim --headless +'TSInstallSync regex' +qall
RUN lvim --headless +'TSInstallSync vim' +qall
RUN lvim --headless +'TSInstallSync vimdoc' +qall
RUN lvim --headless +'TSInstallSync ini' +qall
RUN lvim --headless +'TSInstallSync python' +qall
RUN lvim --headless +'TSInstallSync gitignore' +qall
## For tests
RUN pip install pytest
COPY tests tests
# RUN pytest tests

COPY start* /root
CMD "/root/start.sh"

## install font on your client
# curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip -o UbuntuMono.zip
