#!/bin/bash

mkdir -p dist

cargo run --release

cp -r assets dist/assets
