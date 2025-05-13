#!/bin/bash

# This script helps with installing Noesis Core as a dependency
# to be used by Noesis Extend

# Set default Noesis repository URL and tag
NOESIS_REPO="https://github.com/void-sign/noesis.git"
NOESIS_TAG="v1.0.0"
INSTALL_DIR="../noesis"

# Parse command line arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
        -r|--repo)
            NOESIS_REPO="$2"
            shift 2
            ;;
        -t|--tag)
            NOESIS_TAG="$2"
            shift 2
            ;;
        -d|--dir)
            INSTALL_DIR="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: ./install_dependency.sh [options]"
            echo "Options:"
            echo "  -r, --repo URL   Specify Noesis repository URL"
            echo "  -t, --tag TAG    Specify Noesis version tag"
            echo "  -d, --dir DIR    Specify installation directory"
            echo "  -h, --help       Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

echo "Installing Noesis Core dependency"
echo "================================"
echo "Repository: $NOESIS_REPO"
echo "Version:    $NOESIS_TAG"
echo "Directory:  $INSTALL_DIR"
echo

# Check if directory exists
if [ -d "$INSTALL_DIR" ]; then
    echo "Directory already exists. Do you want to remove it? [y/N]"
    read confirm
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        rm -rf $INSTALL_DIR
    else
        echo "Aborting installation."
        exit 1
    fi
fi

# Clone the repository
echo "Cloning Noesis Core repository..."
git clone $NOESIS_REPO $INSTALL_DIR
if [ $? -ne 0 ]; then
    echo "Failed to clone repository!"
    exit 1
fi

# Switch to the specified tag
cd $INSTALL_DIR
echo "Checking out version $NOESIS_TAG..."
git checkout $NOESIS_TAG
if [ $? -ne 0 ]; then
    echo "Failed to checkout tag $NOESIS_TAG!"
    echo "Available tags:"
    git tag
    exit 1
fi

# Build the core
echo "Building Noesis Core..."
if [ -f "./install.sh" ]; then
    ./install.sh
elif [ -f "./install.fish" ]; then
    if command -v fish &> /dev/null; then
        fish ./install.fish
    else
        echo "Fish shell not found, trying make directly..."
        make
    fi
else
    make
fi

if [ $? -ne 0 ]; then
    echo "Failed to build Noesis Core!"
    exit 1
fi

# Set environment variables
cd ..
NOESIS_HOME=$(pwd)/$INSTALL_DIR
echo "Noesis Core installed successfully at: $NOESIS_HOME"
echo "To use it with Noesis Hub, run:"
echo "export NOESIS_CORE_PATH=$NOESIS_HOME"

# Export for current session
export NOESIS_CORE_PATH=$NOESIS_HOME
export NOESIS_HOME=$NOESIS_HOME
