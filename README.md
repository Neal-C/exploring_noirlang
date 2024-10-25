# Exploring Noirlang

https://noir-lang.org/ && https://github.com/noir-lang/noir

in version 0.36.0 at time for writing

## Raison d'être  

The Universal Language of Zero-Knowledge.
"The current zk stack is cumbersome and hard to understand" - Aztec Network, Oct. 6, 2022  
Noir is an open-source Domain-Specific Language for safe and seamless construction of privacy-preserving Zero-Knowledge programs, requiring no previous knowledge on the underlying mathematics or cryptography.

## Notes

- Noir is a Rust-based domain specific language (DSL) for creating and verifying zero-knowledge proofs

- Noir is an open-source Domain-Specific Language for safe and seamless construction of privacy-preserving Zero-Knowledge programs, requiring no previous knowledge on the underlying mathematics or cryptography.

- Noir is designed to abstract away complexity without any significant overhead

- Rust syntax !

- the default backend for noir is Barretenberg

- proving backends, the default proving backend for noir is Barretenberg

- Proving backends provide the ability to generate and verify proofs of executing Noir programs, following Noir's tooling that compiles and executes the programs

- Noir is backend agnostic, which means it makes no assumptions on which proving backend powers the ZK proof

- Noir is meant to be easy to extend by simply importing Noir libraries just like in Rust

- Prover.toml file

- `nargo execute witness-name`

- The witness concept

- Noir can be used for : Aztec Network contracts, Solidity verifiers and Fullstack development

- [Pedersen hashes](https://www.nccgroup.com/us/research-blog/breaking-pedersen-hashes-in-practice/)

- Noir has its own package manager, nargo, that mocks Rust’s crate and package management system. nargo supports using dependencies uploaded to Github.

- straight out of the box Noir allows you to build a compiled Solidity contract to verify proofs on any EVM-compatible blockchain. Smart contract developers can now execute logic based on Noir proofs.

- Designed to have a rich standard library, especially on cryptography functions. The stdlib gives developers access to widely used, complex algorithms that are hand-written and tightly optimized by the Aztec team.

- Noir doesn’t compile directly to circuits but to an intermediary representation (akin to LLVM), it is compatible with multiple back-end proving systems including PLONK, Groth16, and Marlin.

- this intermediate representation is called an ACIR (Abstract Circuit Intermediate Representation).

- developing with Noir means you can plug in any SNARK-based proving system according to your needs.

- Private values are also referred to as witnesses sometimes.

- The size of a Noir field depends on the elliptic curve's finite field for the proving backend adopted

- `sng0` : Parity of (prime) Field element, i.e. sgn0(x mod p) = 0 if x ∈ {0, ..., p-1} is even, otherwise sgn0(x mod p) = 1.

- NP completeness. The name "NP-complete" is short for "nondeterministic polynomial-time complete". In this name, "nondeterministic" refers to nondeterministic Turing machines, a way of mathematically formalizing the idea of a brute-force search algorithm. Polynomial time refers to an amount of time that is considered "quick" for a deterministic algorithm to check a single solution, or for a nondeterministic Turing machine to perform the whole search. "Complete" refers to the property of being able to simulate everything in the same complexity class.

- As of 0.36.0, Oracles are an experimental feature. "Noir has support for Oracles via RPC calls. This means Noir will make an RPC call and use the return value for proof generation."

- As of 0.36.0, Data bus is an experimental feature.

- Supports meta-programming with the `comptime` keyword.

- Noir has the concept of "quotes" and "quoted" code. Noir's quote is actually a quasiquote. (Quotes are somewhat a LISP concept)

- The Noir team is progressively adding new cryptographic primitives to the standard library

- Same built-in testing as Rust

- Noir has WASM support

- Noir has the ability to generate a verifier contract in Solidity, which can be deployed in many EVM-compatible blockchains such as Ethereum. This allows for a powerful feature set, as one can make use of the conciseness and the privacy provided by Noir in an immutable ledger.

- A circuit doesn't have the concept of a return value. Return values are just syntactic sugar in Noir. Under the hood, the return value is passed as an input to the circuit and is checked at the end of the circuit program.

- Noir has a module to do codegen into Typescript, for the Noir Frontend Apps

- Merkleproofs are part of the standard library


## Bugs (noirlang toolchain 0.36.0)

- At time of writing, noir-lang is in 0.36.0 and the latest Barretenberg version is 0.55.0 : the latest version of Barretenberg is not compatible with noir-lang 0.36.0 and cannot be used to prove 0.36.0-noir-compiled programs. I had to downgrade to noirlang 0.34.0

## Toolchain & Ecosystem

- 2 Typescript libraries
  - NoirJS, which enables the compiling of Noir circuits in the browser
  - Barretenberg.js, which enables proving and verifying those circuits in the browser.
  - https://github.com/AztecProtocol/aztec-packages
  - https://www.npmjs.com/package/@aztec/bb.js

### Types system notes

- the Field type. The field type corresponds to the native field type of the proving backend

- integer overflow will error and stop execution

- for times where overflow is the intended behavior, the standard library provides functions like`fn wrapping_add<T>(x: T, y: T) -> T;`

- The string type is a fixed length value defined with `str<N>`. `pub str<11>`

- At time of writing, with version 0.36.0 : Slices are an experimental feature

- field attributes (../src/field.nr)

### Error handling notes

- 
- 

### Memory management notes

-  

### Build system notes

- 

## Claims

- it’s the easiest way to write zk applications that are compatible with any proving system.

- Noir can be used both in complex cloud-based backends and in user's smartphones, requiring no knowledge on the underlying math or cryptography. From authorization systems that keep a password in the user's device, to complex on-chain verification of recursive proofs

- Noir makes the creation of zk circuits–and applications–easier than ever.

## Instructions

Requirements: Docker or Noirlang toolchain = 0.36.0


#### With Docker

clone my repository

```shell
git clone git@github.com:Neal-C/exploring_noirlang.git
cd exploring_noirlang
```

build and run with Docker

```shell
docker build -t neal-c-noirlang:latest .
```

```shell
docker run --name neal-c-noirlang neal-c-noirlang:latest
```


### With local install

Requirements: Noirlang toolchain = 0.36.0 and Barretenberg = 0.55.0

clone my repository

```shell
git clone git@github.com:Neal-C/exploring_noirlang.git
cd exploring_noirlang
```

execute:  
```bash
nargo execute witness-name
```

prove execution of the program:  
```bash
bb prove -b ./target/exploring_noirlang.json -w ./target/witness-name.gz -o ./target/proof
```

compute the verification key:  
```bash
bb write_vk -b ./target/exploring_noirlang.json -o ./target/vk
```

verify the execution of the proof:  
```bash
# should complete silence if proof is valid and error if not
bb verify -k ./target/vk -p ./target/proof
```

#### Generate a Solidity verifier contract

```bash
nargo compile
```

```bash
# Here we pass the path to the newly generated Noir artifact.
bb write_vk -b ./target/exploring_noirlang.json
```

```bash
# generates a contract.sol
bb contract
```

convert binary proof to hex string

with a shell script

```bash
# make the script executable
chmod +x ./create_hexstring_proof.sh
```

run the script 

```bash
./create_hexstring_proof.sh
```

or manually 

```bash
NUM_PUBLIC_INPUTS=2
PUBLIC_INPUT_BYTES=$((32 * $NUM_PUBLIC_INPUTS))
HEX_PUBLIC_INPUTS=$(head -c $PUBLIC_INPUT_BYTES ./target/proof | od -An -v -t x1 | tr -d $' \n')
HEX_PROOF=$(tail -c +$(($PUBLIC_INPUT_BYTES + 1)) ./target/proof | od -An -v -t x1 | tr -d $' \n')

echo "Public inputs:"
echo $HEX_PUBLIC_INPUTS

echo "Proof:"
echo "0x$HEX_PROOF"
echo "0x$HEX_PROOF" > proof_in_hexstring.txt
```

## Resources

- https://noir-lang.org/docs
- https://aztec.network/learn
- https://github.com/AztecProtocol/barretenberg
- https://github.com/AztecProtocol/aztec-packages/blob/master/barretenberg/cpp/src/barretenberg/bb/readme.md#installation
- https://zokrates.github.io/
- https://docs.circom.io/getting-started/proving-circuits/
- https://github.com/iden3/circom
- https://github.com/noir-lang/noir-examples/blob/33e598c257e2402ea3a6b68dd4c5ad492bce1b0a/foundry-voting/src/zkVote.sol#L35
- https://noir-lang.org/docs/tutorials/noirjs_app
- https://github.com/noir-lang/awesome-noir