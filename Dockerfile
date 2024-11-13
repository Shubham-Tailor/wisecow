# Start your image with a node base image
FROM ubuntu:latest

# Install node packages, install serve, build the app, and remove dependencies at the end
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay && \
    rm -rf /var/lib/apt/lists/*

# Copy the shell script to the container
COPY wisecow.sh /app/wisecow.sh

# Make the script executable
RUN chmod +x /app/wisecow.sh

# Expose the port used by the Wisecow app
EXPOSE 4499

# Start the application
CMD ["/app/wisecow.sh"]