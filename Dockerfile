# I take no responsability for bloated Dockerfiles. Proceed at your own risk and do your own due diligence! :)
FROM node:lts-bookworm-slim AS noirlang
SHELL ["/bin/bash", "-c"]
RUN apt update && apt install -y curl bash git tar gzip libc++-dev jq
RUN curl -L https://raw.githubusercontent.com/noir-lang/noirup/main/install | bash
ENV PATH="/root/.nargo/bin:$PATH"
RUN noirup --version 0.34.0

RUN curl -L https://raw.githubusercontent.com/AztecProtocol/aztec-packages/master/barretenberg/cpp/installation/install | bash

ENV PATH="/root/.bb/:$PATH"

RUN bbup -v 0.55.0

FROM noirlang

WORKDIR /exploration

COPY . .

RUN nargo execute witness-name

RUN bb prove -b ./target/exploring_noirlang.json -w ./target/witness-name.gz -o ./target/proof

RUN bb write_vk -b ./target/exploring_noirlang.json -o ./target/vk

# Should complete in silence if proof is valid
# CMD ["bb" ,"verify" ,"-k" ,"./target/vk", "-p", "./target/proof"]

# Should complete in silence if proof is valid
RUN bb verify -k ./target/vk -p ./target/proof

# Funnier
CMD ["nargo", "execute", "witness-name"]



