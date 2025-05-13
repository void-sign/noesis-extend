#!/bin/bash

# Run script for Noesis Hub (restructured)

# Check if the executable exists
if [ ! -f "./bin/noesis_hub" ]; then
    echo "Noesis Hub executable not found. Building first..."
    ./scripts/bash/install.sh
    if [ $? -ne 0 ]; then
        echo "Build failed. Please check the error messages above."
        exit 1
    fi
fi

# Set library path if external API libraries are found
if [ -n "$NOESIS_LIB" ]; then
    # Add the library path to LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$NOESIS_LIB:$LD_LIBRARY_PATH
    
    # For macOS, also set DYLD_LIBRARY_PATH
    if [ "$(uname)" = "Darwin" ]; then
        export DYLD_LIBRARY_PATH=$NOESIS_LIB:$DYLD_LIBRARY_PATH
    fi
    
    echo "API connection libraries found at: $NOESIS_LIB (optional)"
else
    echo "Running in standard mode (API connectivity libraries not found)"
fi

echo "Running Noesis Hub..."
./bin/noesis_hub "$@"
