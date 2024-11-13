# Start with an Ubuntu base image
FROM ubuntu:latest

# Install the required packages for the application
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay dos2unix && \
    rm -rf /var/lib/apt/lists/*

# Copy the shell script into the container
COPY wisecow.sh /app/wisecow.sh

# Convert line endings from Windows to Unix format and make the script executable
RUN dos2unix /app/wisecow.sh && chmod +x /app/wisecow.sh

# Expose the application port
EXPOSE 4499

# Run the application
CMD ["/app/wisecow.sh"]
