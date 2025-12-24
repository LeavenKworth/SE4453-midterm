#!/bin/sh
# Minimal entrypoint for container: start sshd (on port 2222) and then run the Flask app

# Ensure ssh directory exists for runtime
mkdir -p /var/run/sshd

# Start sshd in background
/usr/sbin/sshd

# Run the Python application
exec python app.py
