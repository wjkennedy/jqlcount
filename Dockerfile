FROM openjdk:11

# Maintainers on this project are the following:
MAINTAINER William Kennedy <william@a9group.net>

# Add Atlassian SDK repository to sources list
RUN echo "deb https://packages.atlassian.com/atlassian-sdk-deb/ stable contrib" >>/etc/apt/sources.list \
    && wget https://packages.atlassian.com/api/gpg/key/public \
    && apt-key add public \
    && apt-get update \
    && mkdir /opt/atlas \
    && cd /opt/atlas \
    && wget https://marketplace.atlassian.com/download/apps/1210992/version/42510 -O sdk-installer.deb \
    && dpkg -i sdk-installer.deb \
    && apt-get install -y python3 git

# Clone the plugin repository
ARG GIT_REPO_URL
RUN git clone ${GIT_REPO_URL} /opt/plugin

# Change working directory to plugin directory
WORKDIR /opt/plugin

# Build the plugin
RUN atlas-mvn package

# Run JIRA with the plugin installed
CMD ["atlas-run", "--product", "jira", "--plugin", "my-plugin-key"]

