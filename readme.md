# CF Solana API

This is the development repo for [Solana API](https://docs.solana.com/developing/clients/jsonrpc-api) integrated with [Adobe ColdFusion](https://coldfusion.adobe.com/).

## Running Locally

### Prerequisites

1. [Docker](https://www.docker.com/) or other container virtualization software.
2. [Postman](https://www.postman.com/) - We will use this to test the API's. Download and import our specific [CF Solana Snapshot](https://www.getpostman.com/collections/393462fe546943d1a8c0).
3. A Solana account is needed to call the Solana API. Download a Solana wallet such as [Phantom](https://phantom.app/download) to create a new account and receive a wallet address.

### Getting Started

1. Clone this repository down to your computer.
2. Move in to the `/bin` folder where all of our Docker setup files are.
3. Run `docker-compose build`
4. Run `docker-compose up -d`
5. Wait a few minutes (the server takes a while to initialize)
6. Open web browser to `localhost:8080`
7. Follow through the ContentBox wizard to setup the first user of the CMS.


## Troubleshooting

**Question**: How do I manually restart the ColdBox server from within the docker container?

**Answer**: Navigate to the installation directory, in our case that is `/app`. From there, run `box` to initialize the ColdBox REPL. Then, once it is loaded you should see the commandbox the welcome message. Run `server stop` to stop the server. You can verify what the status of the server is by running `server list`. Then, to restart the server run `server start host=0.0.0.0 port=8080 openbrowser=false verbose=true`. It is important that the server is run on `0.0.0.0` so that it is accessible to outside of the container without using something like NGINX. 

**Question**: How do I enter a docker container from the command line?

**Answer**: First will need to list out all the running docker containers with `docker ps`. Find the container that want to enter and look for the name under the `NAMES` column. Then, run `docker exec -it <container_name> /bin/bash`. You will be moved into the docker container and can run commands from that system.