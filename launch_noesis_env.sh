#!/bin/bash

# launch_noesis_env.sh - Setup environment for working with both repositories
# This script helps developers work with both Noesis Core and Noesis Hub

if [ $# -eq 0 ]; then
    echo "Usage: ./launch_noesis_env.sh [core_path] [extend_path]"
    echo
    echo "Arguments:"
    echo "  core_path   - Path to Noesis Core repository (default: ../noesis)"
    echo "  extend_path - Path to Noesis Hub repository (default: ../noesis-hub)"
    echo
    echo "This script will:"
    echo "  1. Set up environment variables for cross-repository development"
    echo "  2. Open VS Code with both repositories"
    echo
    exit 0
fi

# Default paths
CORE_PATH="../noesis"
EXTEND_PATH="../noesis-hub"

# Use arguments if provided
if [ $# -ge 1 ]; then
    CORE_PATH=$1
fi

if [ $# -ge 2 ]; then
    EXTEND_PATH=$2
fi

# Resolve to absolute paths
CORE_PATH=$(realpath $CORE_PATH)
EXTEND_PATH=$(realpath $EXTEND_PATH)

# Check if directories exist
if [ ! -d "$CORE_PATH" ]; then
    echo "Error: Noesis Core directory not found at $CORE_PATH"
    exit 1
fi

if [ ! -d "$EXTEND_PATH" ]; then
    echo "Error: Noesis Hub directory not found at $EXTEND_PATH"
    exit 1
fi

# Set environment variables
export NOESIS_CORE_PATH=$CORE_PATH
export NOESIS_EXTEND_PATH=$EXTEND_PATH
export LD_LIBRARY_PATH=$CORE_PATH/lib:$LD_LIBRARY_PATH

# For macOS
if [ "$(uname)" = "Darwin" ]; then
    export DYLD_LIBRARY_PATH=$CORE_PATH/lib:$DYLD_LIBRARY_PATH
fi

# Open VS Code with both repositories
echo "Environment variables set:"
echo "NOESIS_CORE_PATH=$NOESIS_CORE_PATH"
echo "NOESIS_EXTEND_PATH=$NOESIS_EXTEND_PATH"

if command -v code &> /dev/null; then
    echo "Opening VS Code..."
    code --new-window $CORE_PATH $EXTEND_PATH
else
    echo "VS Code not found in PATH. Please open manually."
fi

# Keep the environment for the user
echo "To use these environment variables in your current shell:"
echo "export NOESIS_CORE_PATH=$NOESIS_CORE_PATH"
echo "export NOESIS_EXTEND_PATH=$NOESIS_EXTEND_PATH"
echo "export LD_LIBRARY_PATH=$CORE_PATH/lib:\$LD_LIBRARY_PATH"
if [ "$(uname)" = "Darwin" ]; then
    echo "export DYLD_LIBRARY_PATH=$CORE_PATH/lib:\$DYLD_LIBRARY_PATH"
fi
