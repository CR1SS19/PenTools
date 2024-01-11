# Use a base image with a minimal OS, like Alpine Linux
FROM ubuntu:latest

# Copy the shell script into the container
COPY EasySetup.sh /EasySetup.sh

# Make the script executable
RUN chmod +x /EasySetup.sh

# Define the default command to run when the container starts
ENTRYPOINT ["/EasySetup.sh"]