#!/bin/fish

echo "Noesis Extend Installation Script"
echo "================================"
echo 

# Check for Noesis Core
if set -q NOESIS_CORE_PATH
    set -gx NOESIS_HOME $NOESIS_CORE_PATH
    echo "Using Noesis Core at: $NOESIS_HOME"
else
    # Try the default location
    if test -d "../noesis"
        set -gx NOESIS_HOME "../noesis"
        echo "Using Noesis Core at default location: $NOESIS_HOME"
    else
        echo "ERROR: Cannot find Noesis Core. Please set NOESIS_CORE_PATH environment variable."
        echo "Example: set -gx NOESIS_CORE_PATH /path/to/noesis"
        echo 
        echo "You can install Noesis Core using our helper script:"
        echo "./scripts/install_dependency.fish"
        exit 1
    end
end

# Step 1: Link with the core library
echo "[Step 1/3] Linking with Noesis Core..."
./link_libraries.fish
if test $status -ne 0
    echo "ERROR: Failed to link with Noesis Core. Please check that Noesis Core is correctly installed."
    exit 1
end
echo "✓ Successfully linked with Noesis Core"

# Step 2: Build the extensions
echo "[Step 2/3] Building Noesis Extend..."
make clean
make
if test $status -ne 0
    echo "ERROR: Build failed."
    exit 1
end
echo "✓ Noesis Extend built successfully"

# Step 3: Run tests
echo "[Step 3/3] Running tests..."
make test
if test $status -ne 0
    echo "WARNING: Some tests may have failed. Please check the output above."
else
    echo "✓ All tests passed"
end

echo
echo "Installation complete!"
echo "======================"
echo "You can now run Noesis Extend with:"
echo "  ./run.fish"
echo
echo "Note: This is a separate repository from Noesis Core."
echo "For issues with the core functionality, please use the Noesis Core repository:"
echo "https://github.com/void-sign/noesis"
echo
echo "Happy extending consciousness!"
