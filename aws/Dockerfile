FROM dariusmurawski/lunarvim_base:latest
RUN apt-get install -y unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -qq awscliv2.zip && \
    ./aws/install && \
    mkdir -p ~/.aws && \
    rm awscliv2.zip && \
    rm -rf aws
