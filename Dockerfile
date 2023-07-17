FROM dariusmurawski/lunarvim_lazygit:latest AS lazygit
FROM dariusmurawski/lunarvim_python:latest AS python
FROM dariusmurawski/lunarvim_powershell7:latest AS powershell7
FROM dariusmurawski/lunarvim_aws:latest AS aws
FROM dariusmurawski/lunarvim_node:latest AS node
FROM dariusmurawski/lunarvim_rust:latest AS rust
FROM rocker/r-ubuntu:22.04 AS r

FROM dariusmurawski/lunarvim_base:latest
# Support lazygit
COPY --from=lazygit /usr/local/bin /usr/local/bin
COPY --from=lazygit /root/.config/ /root/.config/

# Support for python
COPY --from=python /usr/local /usr/local
# COPY --from=powershell7 /usr/bin /usr/bin

# Support for aws
COPY --from=aws /usr/local/bin /usr/local/bin
COPY --from=aws /usr/local/aws-cli/ /usr/local/aws-cli/

# Support for node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin /usr/local/bin

# Support for rust
COPY --from=rust /usr/local/cargo/bin /usr/local/cargo/bin
COPY --from=rust /usr/local/rustup /usr/local/rustup
ENV PATH="/root/.cargo/bin:/usr/local/cargo/bin:/usr/local/rustup:$PATH"
ENV CARGO_HOME=/usr/local/cargo
ENV RUSTUP_HOME=/usr/local/rustup

# Support for R
COPY --from=r /usr/bin/Rscript /usr/bin/Rscript
COPY --from=r /usr/bin/R /usr/bin/R
COPY --from=r /usr/lib/R/ /usr/lib/R/
COPY --from=r /usr/share/R/ /usr/share/R/
COPY --from=r /usr/lib/libR.so /usr/lib/libR.so
COPY --from=r /usr/lib/x86_64-linux-gnu/ /usr/lib/x86_64-linux-gnu/
COPY --from=r /etc/alternatives/ /etc/alternatives/
COPY --from=r /etc/R/ /etc/R/
# neovim and lunarvim
ARG LV_BRANCH=release-1.3/neovim-0.9
RUN  curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install-neovim-from-release | bash && \
     curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install.sh | bash -s -- --no-install-dependencies
ENV PATH="/root/.local/bin:$PATH"

# core update to trigger first boot
RUN lvim +LvimUpdate +qall
COPY config.lua /root/.config/lvim/config.lua
RUN lvim --headless +'Lazy sync' +qall
# LSP
RUN lvim --headless +'MasonInstall ansible-language-server cmake-language-server css-lsp docker-compose-language-service dockerfile-language-server html-lsp python-lsp-server lua-language-server taplo terraform-ls tflint' +qall
# DAP
RUN lvim --headless +'MasonInstall bash-debug-adapter debugpy' +qall
# Linter
RUN lvim --headless +'MasonInstall tflint yamllint markdownlint jsonlint flake8 curlylint ansible-lint' +qall
# Formatter
RUN lvim --headless +'MasonInstall rustfmt yamlfmt jq black' +qall
# Treesitter
RUN lvim --headless +'TSInstallSync lua query markdown_inline comment regex vim vimdoc ini python gitignore dockerfile markdown yaml' +qall

## For tests
RUN pip install pytest
COPY tests tests
RUN pytest tests

COPY start* /root
RUN chmod +x /root/start*
CMD "/root/start.sh"

## install font on your client
# curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip -o UbuntuMono.zip
# For Ubuntu: mkdir -p ~/.fonts/ && mv UbuntuMono.zip ~/.fonts && cd ~/.fonts && unzip UbuntuMono.zip
# For windows, drag and drop via "font" folder under "System Settings".

