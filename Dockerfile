FROM codenvy/jdk7
RUN CLI_VERSION=2.10.0 && \ 
CLI_HOME=/opt/codenvy-cli-$CLI_VERSION && \
CLI_BIN_URL=http://maven.codenvycorp.com/content/repositories/public/com/codenvy/cli/cli-assembly/$CLI_VERSION/cli-assembly-$CLI_VERSION.tar.gz && \
PATH=$CLI_HOME/bin:$PATH && \
wget -qO- $CLI_BIN_URL | sudo tar zx -C /opt/ && \
echo "export PATH=$PATH" >> $HOME/.bashrc && \
sudo chown user:user -R $CLI_HOME && \
sudo apt-get update && \
sudo apt-get install -y git=1:2.1.4-2.1 nodejs=0.10.29~dfsg-2 npm=1.4.21+ds-2 && \
sudo apt-get clean && \
sudo rm -rf /var/lib/apt/lists/* && \
sudo ln -sf /usr/bin/nodejs /usr/bin/node && \
sudo npm install -g strongloop@4.0.3

EXPOSE 3000
ENV CODENVY_APP_PORT_3000_HTTP 3000
ENV CODENVY_APP_BIND_DIR /home/user/runtime
VOLUME ["/home/user/runtime"]
CMD sleep 4h
