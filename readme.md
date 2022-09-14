# CF Solana API

This is the development repo for [Solana API](https://docs.solana.com/developing/clients/jsonrpc-api) integrated with [Adobe ColdFusion](https://coldfusion.adobe.com/).

## Prerequisites

1. [Docker](https://www.docker.com/) or other container virtualization software.

## Getting Started

1. Clone this repository down to your computer.
2. Move in to the `/bin` folder where all of our Docker setup files are.
3. Run `docker-compose build`
4. Run `docker-compose up -d`
5. Wait a few minutes (the server takes a while to initialize)
6. Open web browser to `localhost:8080`
7. Follow through the ContentBox wizard to setup the first user of the CMS.


## Troubleshooting

*Question*: How do I manually restart the ColdBox server from within the docker container?
*Answer*: Navigate to the installation directory, in our case that is `/app`. From there, run `box` to initialize the ColdBox REPL. Then, once it is loaded you should see the commandbox the welcome message. Run `server stop` to stop the server. You can verify what the status of the server is by running `server list`. Then, to restart the server run `server start host=0.0.0.0 port=8080 openbrowser=false verbose=true`. It is important that the server is run on `0.0.0.0` so that it is accessible to outside of the container without using something like NGINX. 