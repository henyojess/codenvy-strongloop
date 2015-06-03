FROM codenvy/jdk7
ENV HOME /home/user
ENV CLI_VERSION 2.10.0 
ENV CLI_HOME /opt/codenvy-cli-$CLI_VERSION
ENV CLI_BIN_URL http://maven.codenvycorp.com/content/repositories/public/com/codenvy/cli/cli-assembly/$CLI_VERSION/cli-assembly-$CLI_VERSION.tar.gz
ENV PATH $CLI_HOME/bin:$PATH 
RUN wget -qO- $CLI_BIN_URL | sudo tar zx -C /opt/ && \
echo "export CLI_HOME=$CLI_HOME" >> $HOME/.bashrc && \
echo "export PATH=$PATH" >> $HOME/.bashrc && \
sudo chown user:user -R $CLI_HOME && \
codenvy login $CODENVY_USER $CODENVY_PASS && \
CODENVY_PROJECT_ID=$(codenvy list | grep $CODENVY_PROJECT | awk '{ print $1}') && \
echo "codenvy clone-local $CODENVY_PROJECT_ID" >> $HOME/.bashrc && \
sudo apt-get update && \
sudo apt-get install -y git nodejs npm && \ 
sudo apt-get clean && \
sudo rm -rf /var/lib/apt/lists/* && \
sudo ln -sf /usr/bin/nodejs /usr/bin/node && \
sudo npm install -g strongloop
EXPOSE 3000
ENV CODENVY_APP_PORT_3000_HTTP 3000
ENV CODENVY_APP_BIND_DIR /home/user/runtime
VOLUME ["/home/user/runtime"]
CMD sleep 4h
