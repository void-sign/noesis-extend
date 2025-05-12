#!/bin/fish
# This script creates links to the Noesis Core library
# for use by Noesis-Extend

# Check for Noesis Core path
if set -q NOESIS_LIBRARY_PATH
    set -gx NOESIS_LIB $NOESIS_LIBRARY_PATH
    echo "Using Noesis Core library at: $NOESIS_LIB"
else if set -q NOESIS_CORE_PATH
    set -gx NOESIS_HOME $NOESIS_CORE_PATH
    set -gx NOESIS_LIB "$NOESIS_HOME/lib"
    echo "Using Noesis Core at: $NOESIS_HOME"
else if set -q NOESIS_HOME
    # Already set, use it
    set -gx NOESIS_LIB "$NOESIS_HOME/lib"
    echo "Using Noesis Core at: $NOESIS_HOME"
else
    # Try default location
    set -gx NOESIS_HOME "../noesis"
    set -gx NOESIS_LIB "$NOESIS_HOME/lib"
    echo "Using default Noesis Core location at: $NOESIS_HOME"
end

# Check if Noesis Core exists
if not test -d "$NOESIS_HOME"
    echo "ERROR: Noesis Core directory not found at $NOESIS_HOME"
    echo "Please set the NOESIS_CORE_PATH environment variable to the correct location"
    echo "or install Noesis Core using ./scripts/install_dependency.fish"
    exit 1
end

# Determine which library extension to use based on platform
if test (uname) = "Darwin"
    set lib_extension "dylib"
else
    set lib_extension "so"
end

# Check if the shared library exists
if not test -f "$NOESIS_LIB/libnoesis_core.$lib_extension"
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
        
        # Build appropriate library for the platform
        if test (uname) = "Darwin"
            gcc -dynamiclib -o lib/libnoesis_core.dylib object/core/*.o object/utils/*.o object/asm/*.o
        else
            gcc -shared -o lib/libnoesis_core.so object/core/*.o object/utils/*.o object/asm/*.o
        end
    end
    
    # Return to our directory
    cd $current_dir
    
    if not test -f "$NOESIS_LIB/libnoesis_core.$lib_extension"
        echo "ERROR: Failed to build shared library from Noesis Core"
        exit 1
    end
end

# Create lib directory if it doesn't exist
mkdir -p lib

# Copy the shared library to our lib directory
cp -f "$NOESIS_LIB/libnoesis_core.$lib_extension" "./lib/"

# Create symbolic links to include directories
mkdir -p include
if test -d "$NOESIS_HOME/include/core"
    ln -sf "$NOESIS_HOME/include/core" include/core
end
if test -d "$NOESIS_HOME/include/utils"
    ln -sf "$NOESIS_HOME/include/utils" include/utils
end

echo "Core library linked to Noesis-Extend successfully"
