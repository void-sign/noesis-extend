#!/bin/bash

echo "Noesis Extend Installation Script"
echo "================================"
echo 

# Check for Noesis Core shared library
NOESIS_FOUND=0

# Check environment variable for Noesis library path
if [ -n "$NOESIS_LIBRARY_PATH" ]; then
    if [ -f "$NOESIS_LIBRARY_PATH/libnoesis_core.so" -o -f "$NOESIS_LIBRARY_PATH/libnoesis_core.dylib" ]; then
        export NOESIS_LIB="$NOESIS_LIBRARY_PATH"
        NOESIS_FOUND=1
        echo "Using Noesis Core library at: $NOESIS_LIB"
    fi
elif [ -n "$NOESIS_CORE_PATH" ]; then
    export NOESIS_HOME=$NOESIS_CORE_PATH
    if [ -f "$NOESIS_HOME/lib/libnoesis_core.so" -o -f "$NOESIS_HOME/lib/libnoesis_core.dylib" ]; then
        export NOESIS_LIB="$NOESIS_HOME/lib"
        NOESIS_FOUND=1
        echo "Using Noesis Core library at: $NOESIS_LIB"
    fi
fi

# If not found, try common locations
if [ $NOESIS_FOUND -eq 0 ]; then
    for location in "/usr/local/lib" "/usr/lib" "../noesis/lib" "/opt/noesis/lib"; do
        if [ -f "$location/libnoesis_core.so" -o -f "$location/libnoesis_core.dylib" ]; then
            export NOESIS_LIB="$location"
            NOESIS_FOUND=1
            echo "Found Noesis Core library at: $NOESIS_LIB"
            break
        fi
    done
fi

# If still not found, offer options
if [ $NOESIS_FOUND -eq 0 ]; then
    echo "Noesis Core library not found. You have these options:"
    echo "1. Download and install Noesis Core"
    echo "2. Specify the path to an existing installation"
    echo "3. Continue without Noesis Core (standalone mode)"
    
    read -p "Choose an option (1-3): " choice
    
    case $choice in
        "1")
            echo "Installing Noesis Core..."
            ./scripts/install_dependency.sh
            if [ -d "../noesis" ] && ([ -f "../noesis/lib/libnoesis_core.so" ] || [ -f "../noesis/lib/libnoesis_core.dylib" ]); then
                export NOESIS_HOME="../noesis"
                export NOESIS_LIB="$NOESIS_HOME/lib"
                NOESIS_FOUND=1
                echo "Noesis Core installed at: $NOESIS_HOME"
            else
                echo "Installation failed. Continuing in standalone mode."
            fi
            ;;
        "2")
            read -p "Enter the path to your Noesis Core installation: " custom_path
            if [ -d "$custom_path" ] && ([ -f "$custom_path/lib/libnoesis_core.so" ] || [ -f "$custom_path/lib/libnoesis_core.dylib" ]); then
                export NOESIS_HOME="$custom_path"
                export NOESIS_LIB="$NOESIS_HOME/lib"
                NOESIS_FOUND=1
                echo "Using Noesis Core at: $NOESIS_HOME"
            else
                echo "Invalid path or Noesis Core not found at specified location."
                echo "Continuing in standalone mode."
            fi
            ;;
        "3")
            echo "Continuing in standalone mode. Noesis Core functionality will be disabled."
            ;;
        *)
            echo "Invalid option. Continuing in standalone mode."
            ;;
    esac
fi

# Save environment variables for future reference
if [ $NOESIS_FOUND -eq 1 ]; then
    if [ "$(uname)" = "Darwin" ]; then
        echo "export NOESIS_HOME=$NOESIS_HOME" > .env
        echo "export NOESIS_LIB=$NOESIS_LIB" >> .env
        echo "export DYLD_LIBRARY_PATH=$NOESIS_LIB:\$DYLD_LIBRARY_PATH" >> .env
    else
        echo "export NOESIS_HOME=$NOESIS_HOME" > .env
        echo "export NOESIS_LIB=$NOESIS_LIB" >> .env
        echo "export LD_LIBRARY_PATH=$NOESIS_LIB:\$LD_LIBRARY_PATH" >> .env
    fi
fi

# Build the project
echo "Building Noesis-Extend..."
make clean
make

if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
else
    echo "Build completed successfully!"
    echo "You can now run Noesis-Extend with: ./run.sh"
fi
