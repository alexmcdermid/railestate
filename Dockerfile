# Use the official Ruby image from the DockerHub
FROM ruby:3.1.2

# Set the 'app' as the working directory within the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock to make use of Docker cache
COPY Gemfile* /app/

# Install system dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libffi-dev

# Install Ruby dependencies
RUN bundle install

# Copy the main application
COPY . /app/

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port 3000 to the Docker host
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]
