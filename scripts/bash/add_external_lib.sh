#!/bin/bash

# add_external_lib.sh - Add external libraries to Noesis Hub without forking
# This script helps developers add external libraries to the project

# Default settings
REPO_URL=""
REPO_TAG=""
INSTALL_DIR=""
LIB_NAME=""
HEADER_DIR="include"
LIB_DIR="lib"
BUILD_COMMAND="make"
SYMLINK_ONLY=0

# Parse command line arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
        -r|--repo)
            REPO_URL="$2"
            shift 2
            ;;
        -t|--tag)
            REPO_TAG="$2"
            shift 2
            ;;
        -d|--dir)
            INSTALL_DIR="$2"
            shift 2
            ;;
        -n|--name)
            LIB_NAME="$2"
            shift 2
            ;;
        -h|--header-dir)
            HEADER_DIR="$2"
            shift 2
            ;;
        -l|--lib-dir)
            LIB_DIR="$2"
            shift 2
            ;;
        -b|--build-command)
            BUILD_COMMAND="$2"
            shift 2
            ;;
        -s|--symlink-only)
            SYMLINK_ONLY=1
            shift
            ;;
        --help)
            echo "Usage: ./add_external_lib.sh [options]"
            echo "Options:"
            echo "  -r, --repo URL          Repository URL to clone"
            echo "  -t, --tag TAG           Specific tag or branch to checkout"
            echo "  -d, --dir PATH          Installation directory"
            echo "  -n, --name NAME         Library name (for linking)"
            echo "  -h, --header-dir PATH   Header directory (default: include)"
            echo "  -l, --lib-dir PATH      Library directory (default: lib)"
            echo "  -b, --build-command CMD Build command (default: make)"
            echo "  -s, --symlink-only      Only create symlinks (don't clone/build)"
            echo "  --help                  Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information."
            exit 1
            ;;
    esac
done

# Validate inputs
if [ $SYMLINK_ONLY -eq 0 ]; then
    if [ -z "$REPO_URL" ]; then
        echo "Error: Repository URL is required."
        echo "Use --help for usage information."
        exit 1
    fi
    
    if [ -z "$INSTALL_DIR" ]; then
        echo "Error: Installation directory is required."
        echo "Use --help for usage information."
        exit 1
    fi
fi

if [ -z "$LIB_NAME" ]; then
    echo "Error: Library name is required."
    echo "Use --help for usage information."
    exit 1
fi

echo "Adding external library: $LIB_NAME"
echo "=================================="

# Clone repository if needed
if [ $SYMLINK_ONLY -eq 0 ]; then
    echo "Repository: $REPO_URL"
    echo "Directory:  $INSTALL_DIR"
    
    # Check if directory exists
    if [ -d "$INSTALL_DIR" ]; then
        echo "Directory already exists. Do you want to remove it? [y/N]"
        read confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            rm -rf $INSTALL_DIR
        else
            echo "Using existing directory."
        fi
    fi
    
    # Clone if directory doesn't exist
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Cloning repository..."
        git clone $REPO_URL $INSTALL_DIR
        if [ $? -ne 0 ]; then
            echo "Failed to clone repository!"
            exit 1
        fi
        
        # Checkout specific tag/branch if specified
        if [ -n "$REPO_TAG" ]; then
            cd $INSTALL_DIR
            git checkout $REPO_TAG
            if [ $? -ne 0 ]; then
                echo "Failed to checkout $REPO_TAG!"
                exit 1
            fi
            cd - > /dev/null
        fi
    fi
    
    # Build the library
    echo "Building library..."
    current_dir=$(pwd)
    cd $INSTALL_DIR
    eval $BUILD_COMMAND
    if [ $? -ne 0 ]; then
        echo "Build failed!"
        cd $current_dir
        exit 1
    fi
    cd $current_dir
fi

# Create directories if they don't exist
mkdir -p lib
mkdir -p include/$LIB_NAME

# Determine library path
if [ $SYMLINK_ONLY -eq 1 ]; then
    # Use the full specified path
    lib_path="$LIB_DIR"
else
    # Use the installation directory
    lib_path="$INSTALL_DIR/$LIB_DIR"
fi

# Determine header path
if [ $SYMLINK_ONLY -eq 1 ]; then
    # Use the full specified path
    header_path="$HEADER_DIR"
else
    # Use the installation directory
    header_path="$INSTALL_DIR/$HEADER_DIR"
fi

# Create symbolic links for libraries
echo "Creating symbolic links for libraries..."

# Determine which library extension to use based on platform
if [ "$(uname)" = "Darwin" ]; then
    lib_extension="dylib"
else
    lib_extension="so"
fi

# Try different library naming patterns
for lib_pattern in "$lib_path/lib$LIB_NAME.$lib_extension" "$lib_path/lib$LIB_NAME.a"; do
    for lib_file in $lib_pattern; do
        if [ -f "$lib_file" ]; then
            ln -sf "$lib_file" "lib/$(basename "$lib_file")"
            echo "Linked: $lib_file"
        fi
    done
done

# Create symbolic links for headers
echo "Creating symbolic links for headers..."
if [ -d "$header_path" ]; then
    # Link individual header files to avoid conflicts
    for header in "$header_path"/*.h; do
        if [ -f "$header" ]; then
            ln -sf "$header" "include/$LIB_NAME/$(basename "$header")"
            echo "Linked header: $header"
        fi
    done
else
    echo "Warning: Header directory not found at $header_path"
fi

echo
echo "Library $LIB_NAME added successfully!"
echo "To use this library in your code:"
echo "  1. Include headers with: #include \"$LIB_NAME/header.h\""
echo "  2. Update your Makefile to link with -l$LIB_NAME"
echo
