# JIRA Issue Count Plugin

## Overview

This JIRA plugin provides a REST endpoint to count issues based on a specified JQL query and updates a custom field ("Experience Notes") with the count, along with user-configurable text.

## Prerequisites

Jira Software (Data Center or Server)
Atlassian SDK

## Installation

Clone or download the plugin source code to your local machine.
Navigate to the plugin directory.

Build the plugin with the Atlassian SDK:

    atlas-package

Deploy the generated .jar file to your JIRA instance via the Manage add-ons page.

## Configuration

### Custom Field Configuration:

Ensure the custom field "Experience Notes" is created in JIRA.
Configure the field to be visible in the relevant project screens.

### Text Configuration:

The text appended to the issue count is configurable.
Set this by updating the JIRA's application properties:

    plugin.customfield.appendtext=Your Custom Text Here

If not set, the default text will be " number of issues reported in an hour".
Usage
To use the plugin, make a GET request to the REST endpoint:

    /rest/issuecount/1.0/issuecount?jql=YOUR_JQL_QUERY

This will return the issue count and update the "Experience Notes" custom field with this count and the configured (or default) text.

### Development

To run the plugin locally for development:

    atlas-run

### Testing

Test the REST endpoint using tools like Postman or curl.
Verify that the issue count is accurate and the custom field is updated correctly.

## Build with Docker

In this Dockerfile:

Git Installation: The git package is installed to enable cloning from the repository.

Git Repository Cloning: A build argument GIT_REPO_URL is used to pass the URL of the Git repository. The repository is cloned into /opt/plugin.

Building the Plugin: The working directory is changed to the plugin directory, and the plugin is built using atlas-mvn package.

Running JIRA with the Plugin: The CMD instruction is updated to run JIRA with the plugin installed. Replace "my-plugin-key" with the actual key of your plugin.

To build this Docker image, use the following command, replacing <your-git-repo-url> with the URL of your Git repository:

    docker build --build-arg GIT_REPO_URL=<your-git-repo-url> -t jira-plugin .

This Dockerfile assumes that your plugin's build process is standard for Atlassian plugins and doesn't require additional dependencies or special steps. You might need to adjust the Dockerfile if your build process is different.

