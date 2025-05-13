#!/usr/local/bin/fish

# Run script for Noesis Hub

# Check if the executable exists
if not test -f "./bin/noesis_hub"
    echo "Noesis Hub executable not found. Building first..."
    ./scripts/fish/install.fish
    if test $status -ne 0
        echo "Build failed. Please check the error messages above."
        exit 1
    end
end

# Set library path if external API libraries are found
if set -q NOESIS_LIB
    # Add the library path to LD_LIBRARY_PATH
    set -gx LD_LIBRARY_PATH $NOESIS_LIB:$LD_LIBRARY_PATH
    
    # For macOS, also set DYLD_LIBRARY_PATH
    if test (uname) = "Darwin"
        set -gx DYLD_LIBRARY_PATH $NOESIS_LIB:$DYLD_LIBRARY_PATH
    end
    
    echo "API connection libraries found at: $NOESIS_LIB (optional)"
else
    echo "Running in standard mode (API connectivity libraries not found)"
end

echo "Running Noesis Hub..."
./bin/noesis_hub $argv
