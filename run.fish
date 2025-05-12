#!/bin/fish

# Run script for Noesis-Extend
# This script runs the Noesis-Extend component

# Check if the executable exists
if not test -f "./bin/noesis_extend"
    echo "Noesis-Extend executable not found. Building first..."
    ./install.fish
    if test $status -ne 0
        echo "Build failed. Please check the error messages above."
        exit 1
    end
end

echo "Running Noesis-Extend..."
./bin/noesis_extend $argv
