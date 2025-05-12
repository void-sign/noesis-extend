# This script creates links to the Noesis Core library
# for use by Noesis-Extend

# Check for Noesis Core path
if set -q NOESIS_CORE_PATH
    set -gx NOESIS_HOME $NOESIS_CORE_PATH
else if set -q NOESIS_HOME
    # Already set, do nothing
else
    # Try default location
    set -gx NOESIS_HOME "../noesis"
end

echo "Using Noesis Core at: $NOESIS_HOME"

# Check if Noesis Core exists
if not test -d "$NOESIS_HOME"
    echo "ERROR: Noesis Core directory not found at $NOESIS_HOME"
    echo "Please set the NOESIS_CORE_PATH environment variable to the correct location"
    echo "or install Noesis Core using ./scripts/install_dependency.fish"
    exit 1
end

# Check if the shared library exists
if not test -f "$NOESIS_HOME/lib/libnoesis_core.so"
    # Try to build it if it doesn't exist
    echo "Shared library not found, attempting to build it..."
    set -l current_dir (pwd)
    cd $NOESIS_HOME
    
    # Execute install script if it exists
    if test -f "./install.fish"
        ./install.fish
    else
        # Direct build commands as backup
        CFLAGS="-Wall -Wextra -std=c99 -fPIC" make
        mkdir -p lib
        gcc -shared -o lib/libnoesis_core.so object/core/*.o object/utils/*.o object/asm/*.o
    end
    
    # Return to our directory
    cd $current_dir
    
    if not test -f "$NOESIS_HOME/lib/libnoesis_core.so"
        echo "ERROR: Failed to build shared library from Noesis Core"
        exit 1
    end
end

# Create lib directory if it doesn't exist
mkdir -p lib

# Copy the shared library to our lib directory
cp -f $NOESIS_HOME/lib/libnoesis_core.so ./lib/

# Create symbolic links to include directories
mkdir -p include
ln -sf $NOESIS_HOME/include/core include/core
ln -sf $NOESIS_HOME/include/utils include/utils

echo "Core library linked to Noesis-Extend successfully"
