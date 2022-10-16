#!/bin/bash

MYTMPDIR="$(mktemp -d)"
trap 'rm -rf -- "$MYTMPDIR"' EXIT

echo MYTMPDIR "$MYTMPDIR"

echo "Hello World" |& tee "$MYTMPDIR"/Hello_World.txt

