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

# Set library path if Noesis library is found
if set -q NOESIS_LIB
    # Add the library path to LD_LIBRARY_PATH
    set -gx LD_LIBRARY_PATH $NOESIS_LIB:$LD_LIBRARY_PATH
    
    # For macOS, also set DYLD_LIBRARY_PATH
    if test (uname) = "Darwin"
        set -gx DYLD_LIBRARY_PATH $NOESIS_LIB:$DYLD_LIBRARY_PATH
    end
    
    echo "Using Noesis Core libraries from: $NOESIS_LIB"
else
    echo "Running in standalone mode (Noesis Core functionality disabled)"
end

echo "Running Noesis Hub..."
./bin/noesis_hub $argv
