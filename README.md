# Railestate

## Overview

Railestate is a web application built with Ruby on Rails 7, serving as a playground for exploring the Hotwired suite. This suite, which includes Turbo and Stimulus, allows for SPA-like interactivity within a Rails application. Tailwind CSS is used for styling, and PostgreSQL serves as the database. The application also supports OAuth authentication with Google and enables image uploads that are stored in AWS. For consistent development and deployment, Railestate is containerized using Docker.

## Features

- **User Authentication**: Users can sign up using their email and password or via Google OAuth.
- **Railestate Listings**: Users can post real estate ads with detailed information.
- **Image Uploads**: Support for uploading and storing images related to listings in AWS.
- **SPA Functionality**: Uses Hotwire's Turbo and Stimulus for a fast, SPA-like user experience.
- **Dockerization**: Containerized environment for consistent development and deployment.

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
