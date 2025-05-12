#!/bin/bash

# Run script for Noesis-Extend

# Check if the executable exists
if [ ! -f "./bin/noesis_extend" ]; then
    echo "Noesis-Extend executable not found. Building first..."
    ./install.sh
    if [ $? -ne 0 ]; then
        echo "Build failed. Please check the error messages above."
        exit 1
    fi
fi

# Set library path if Noesis library is found
if [ -n "$NOESIS_LIB" ]; then
    # Add the library path to LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$NOESIS_LIB:$LD_LIBRARY_PATH
    
    # For macOS, also set DYLD_LIBRARY_PATH
    if [ "$(uname)" = "Darwin" ]; then
        export DYLD_LIBRARY_PATH=$NOESIS_LIB:$DYLD_LIBRARY_PATH
    fi
    
    echo "Using Noesis Core libraries from: $NOESIS_LIB"
else
    echo "Running in standalone mode (Noesis Core functionality disabled)"
fi

echo "Running Noesis-Extend..."
./bin/noesis_extend "$@"
