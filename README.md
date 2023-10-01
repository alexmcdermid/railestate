# Railestate

## Overview

Railestate is a web application built with Ruby on Rails 7, serving as a playground for exploring the Hotwired suite. This suite, which includes Turbo and Stimulus, allows for SPA-like interactivity within a Rails application. Tailwind CSS is used for styling, and PostgreSQL serves as the database. The application also supports OAuth authentication with Google and enables image uploads that are stored in AWS. For consistent development and deployment, Railestate is containerized using Docker. The application also features a RESTful API for programmatic access to Railestate listings.

## Features

- **User Authentication**: Users can sign up using their email and password or via Google OAuth.
- **Railestate Listings**: Users can post real estate ads with detailed information.
- **Image Uploads**: Support for uploading and storing images related to listings in AWS.
- **SPA Functionality**: Uses Hotwire's Turbo and Stimulus for a fast, SPA-like user experience.
- **Dockerization**: Containerized environment for consistent development and deployment.
- **RESTful API**: Provides a RESTful API that allows you to programmatically manage and retrieve Railestate listings.
- **Swagger Documentation**: Detailed explanation and interactive capabilities for the API, please log in and navigate to the Swagger documentation available on your profile page (Coming Soon).

## Tech Stack

- **Backend**: Ruby on Rails 7
- **Frontend**: Tailwind CSS
- **Database**: PostgreSQL
- **JavaScript**: Stimulus
- **SPA Interactivity**: Turbo
- **Image Storage**: AWS
- **Containerization**: Docker

## Getting Started with Docker

### Why Use Docker?

Docker allows you to encapsulate all the dependencies and configurations into a single container, ensuring that the application runs consistently across various environments.

### Setting up Environment Variables

Before running the application, create a `.env` file based on the provided `.env.sample` and fill in the required values.

### Running Locally Using Docker

1. **Build the Docker Image**
    ```bash
    docker build -t railestate .
    ```
    This command builds a Docker image named `railestate`, utilizing the instructions laid out in the Dockerfile.

2. **Run the Docker Container**
    ```bash
    docker run -p 3000:3000 railestate
    ```
    This runs a container based on the `railestate` image and maps port 3000 inside the container to port 3000 on your local machine.

3. **Access the Application**
    Open a web browser and navigate to `http://localhost:3000` to access the application.

4. **Stopping the Container**
    To halt the running container, find the container ID with the `docker ps` command, then stop it using `docker stop <CONTAINER_ID>`.

## Contributing to Railestate

We welcome contributions to Railestate! This section outlines the process for contributing to the project.

### Getting Started

1. **Fork the Repository**:  
   - First, fork the Railestate repository to your own GitHub account.

2. **Clone Your Fork**:  
   - Clone the forked repository to your local machine using `git clone`.

### Creating an Issue

Before making any changes, it's good practice to create an issue describing the bug you're fixing or the feature you're adding. This gives team members and maintainers a chance to give feedback before you invest time in a pull request.

1. Navigate to the **Issues** tab in the Railestate repository.
2. Create a new issue, providing as much detail as possible.

### Working on Your Feature or Bug Fix

1. **Create a Branch**:  
   - Always create a new branch for each issue you are working on. Name your branch something descriptive that indicates its purpose, e.g., `feature/add-oauth-support` or `bugfix/resolve-login-issue`.

2. **Commit Your Changes**:  
   - Make your changes and commit them to your branch. Use clear and descriptive commit messages.

### Testing

Ensure that you test your changes thoroughly before submitting a pull request.

### Submitting a Pull Request

1. **Push to Your Fork**:  
   - Push your changes to the branch in your forked repository on GitHub.

2. **Create a Pull Request**:  
   - Navigate to the **Pull Requests** tab in the original Railestate repository, and click "New Pull Request."

3. **Base and Compare**:  
   - Set the base repository to `Railestate`'s main branch and the compare repository to your forked repo's branch.

4. **Submit**:  
   - Submit your pull request and provide a brief summary of the changes you've made.

### Code Review

Once a pull request is open, maintainers will review your code. They may request changes or clarifications. Once all comments have been addressed, the pull request can be merged.

### Merging

Since the main branch is protected, only maintainers can merge pull requests. After a successful code review, a maintainer will merge your changes.
