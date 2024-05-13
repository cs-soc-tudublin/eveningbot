from rust as builder
workdir /

run mkdir src
run echo 'fn main(){println!("Hello world")}'>src/main.rs

copy Cargo.toml Cargo.toml
copy Cargo.lock Cargo.lock

run cargo build --release

copy src/ src/
run cargo build --release

from debian:stable-slim as debug

run apt update && apt install -y libssl-dev

copy --from=builder /target/release/eveningbot /eveningbot/eveningbot
copy --from=builder /assets/fact_check/* /eveningbot/assets/fact_check

cmd ["/eveningbot/eveningbot"]
