#!/bin/bash

# This script is the single source of truth for generating Protobuf code.
# It ensures the 'buf' tool is installed and then uses it to generate code
# based on the configurations in 'buf.yaml' and 'buf.gen.yaml'.

set -e

# --- Tool Check & Installation for 'buf' ---
# Check if buf is installed and in the PATH. If not, install it to a local bin directory.
if ! command -v buf &> /dev/null
then
    echo "INFO: 'buf' command not found. Installing locally to ./bin ..."
    # Create a local bin directory if it doesn't exist.
    mkdir -p bin
    # Download and install buf into our local bin.
    # This keeps the installation local to the project.
    go install github.com/bufbuild/buf/cmd/buf@latest
    # Add our local bin to the PATH for the duration of this script.
    export PATH="$(go env GOPATH)/bin:$PATH"
    echo "INFO: 'buf' has been installed."
fi

echo "INFO: All required tools are available."
echo "INFO: Generating Go code..."

# Run buf generate. It reads buf.yaml and buf.gen.yaml to perform the generation.
buf generate

echo "SUCCESS: Code generation complete. New code is in 'protoc-gen/go'."
