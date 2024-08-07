# authenticated-file-server
Securely serve a file using Public-key cryptography

## Usage
The below environment variables should be provided. The container will allow connections on port 22 as the user "user" providing the matching private key.
Using SCP the provided file can be downloaded.

## Environment variables
PUBLIC\_KEY - should contain the public key. Is pasted into authorized\_keys of the user\
FILE - Stored as "the-file" in the users home directory (/home/user/the-file)

