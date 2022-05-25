# sample_contracts

Sample smart contracts for substrate-based ecosystem based on ink! Examples similar to the one given with ink documentation.

# Roadmap

- [ ] Empty Templates
- [ ] ERC20 style contracts
- [ ] ERC741 style contracts
- [ ] Sample Legal contracts
- [ ] Sample DeFi contracts

# Installation

1. Install and setup the Rust ecosystem. If you are using macOS or Linux (Ubuntu etc.) you can get started with the following command
```
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
$ source ~/.cargo/env
```
If you are using windows, please checkout this [link](https://forge.rust-lang.org/infra/other-installation-methods.html)



2. Install and setup, parity and ink! modules.

Install the build dependencies (for ubuntu)
```
$ sudo apt update
$ sudo apt install -y git clang curl libssl-dev llvm libudev-dev pkg-config
```

For other systems please check the documentation [here](https://docs.substrate.io/v3/getting-started/installation/)

Configure the Rust toolchain to latest version and add nightly wasm target
```
$ rustup default stable
$ rustup update
$ rustup update nightly
$ rustup target add wasm32-unknown-unknown --toolchain nightly
```

install dylint
```
$ cargo install cargo-dylint dylint-link
```

After you have installed the package, execute the following command
```
$ cargo install cargo-contract --force --locked
```

Run the following commands
```
$ rustup component add rust-src --toolchain nightly
$ rustup target add wasm32-unknown-unknown --toolchain nightly
```

Install substrate smart contracts Node
```
cargo install contracts-node --git https://github.com/paritytech/substrate-contracts-node.git --tag v0.12.0 --force --locked
```

This is just an overview, you can find the full documentation [here](https://ink.substrate.io/getting-started/setup)


# Create a sample ink! Project

A sample flipper code can be made by running
```
$ cargo contract new flipper
```