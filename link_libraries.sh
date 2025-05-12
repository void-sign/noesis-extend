#!/bin/bash
# This script creates links to the Noesis Core library
# for use by Noesis-Extend

# Check for Noesis Core path
if [ -n "$NOESIS_LIBRARY_PATH" ]; then
    export NOESIS_LIB=$NOESIS_LIBRARY_PATH
    echo "Using Noesis Core library at: $NOESIS_LIB"
elif [ -n "$NOESIS_CORE_PATH" ]; then
    export NOESIS_HOME=$NOESIS_CORE_PATH
    export NOESIS_LIB="$NOESIS_HOME/lib"
    echo "Using Noesis Core at: $NOESIS_HOME"
elif [ -n "$NOESIS_HOME" ]; then
    # Already set, use it
    export NOESIS_LIB="$NOESIS_HOME/lib"
    echo "Using Noesis Core at: $NOESIS_HOME"
else
    # Try default location
    export NOESIS_HOME="../noesis"
    export NOESIS_LIB="$NOESIS_HOME/lib"
    echo "Using default Noesis Core location at: $NOESIS_HOME"
fi

# Check if Noesis Core exists
if [ ! -d "$NOESIS_HOME" ]; then
    echo "ERROR: Noesis Core directory not found at $NOESIS_HOME"
    echo "Please set the NOESIS_CORE_PATH environment variable to the correct location"
    echo "or install Noesis Core using ./scripts/install_dependency.sh"
    exit 1
fi

# Determine which library extension to use based on platform
if [ "$(uname)" = "Darwin" ]; then
    lib_extension="dylib"
else
    lib_extension="so"
fi

# Check if the shared library exists
if [ ! -f "$NOESIS_LIB/libnoesis_core.$lib_extension" ]; then
    # Try to build it if it doesn't exist
    echo "Shared library not found, attempting to build it..."
    current_dir=$(pwd)
    cd $NOESIS_HOME
    
    # Execute install script if it exists
    if [ -f "./install.sh" ]; then
        ./install.sh
    elif [ -f "./install.fish" ]; then
        fish ./install.fish
    else
        # Direct build commands as backup
        CFLAGS="-Wall -Wextra -std=c99 -fPIC" make
    fi
    
    # Check if build was successful
    if [ ! -f "$NOESIS_LIB/libnoesis_core.$lib_extension" ]; then
        echo "ERROR: Failed to build Noesis Core shared library"
        cd "$current_dir"
        exit 1
    fi
    
    cd "$current_dir"
fi

# Create lib directory if it doesn't exist
mkdir -p lib

# Create symbolic links
echo "Creating symbolic links to Noesis Core library..."

if [ -f "$NOESIS_LIB/libnoesis_core.$lib_extension" ]; then
    if [ "$lib_extension" = "dylib" ]; then
        ln -sf "$NOESIS_LIB/libnoesis_core.$lib_extension" lib/libnoesis_core.$lib_extension
    else
        ln -sf "$NOESIS_LIB/libnoesis_core.so" lib/libnoesis_core.so
        if [ -f "$NOESIS_LIB/libnoesis_core.so.1" ]; then
            ln -sf "$NOESIS_LIB/libnoesis_core.so.1" lib/libnoesis_core.so.1
        fi
    fi
    
    echo "Symbolic links created successfully."
else
    echo "ERROR: Noesis Core shared library not found at $NOESIS_LIB"
    exit 1
fi

# Create include symlinks if needed
if [ -d "$NOESIS_HOME/include" ] && [ ! -d "include/noesis" ]; then
    echo "Creating symlinks to Noesis Core headers..."
    mkdir -p include/noesis
    ln -sf "$NOESIS_HOME/include/"* include/noesis/
fi

echo "Noesis Core libraries linked successfully!"
