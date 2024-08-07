# Use the latest specific version of the Ubuntu base image
FROM ubuntu:22.04

# Install OpenSSH server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# Disable root login and password authentication, enable key-based login
RUN sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Set up a non-root user
RUN useradd -m -s /bin/bash user && \
    mkdir /home/user/.ssh && \
    chmod 700 /home/user/.ssh

# Expose port 22
EXPOSE 22

# Add the public key from an environment variable to authorized_keys and create the specified file
CMD echo "$PUBLIC_KEY" > /home/user/.ssh/authorized_keys && \
    chmod 600 /home/user/.ssh/authorized_keys && \
    chown -R user:user /home/user/.ssh && \
    echo "$FILE" > /home/user/the-file && \
    chown user:user /home/user/the-file && \
    /usr/sbin/sshd -D
