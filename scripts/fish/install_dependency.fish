#!/bin/fish

# This script helps with installing Noesis Core as a dependency
# to be used by Noesis Extend

# Set default Noesis repository URL and tag
set -l NOESIS_REPO "https://github.com/void-sign/noesis.git"
set -l NOESIS_TAG "v1.0.0"
set -l INSTALL_DIR "../noesis"

# Parse command line arguments
for i in (seq 1 (count $argv))
    switch $argv[$i]
        case "-r" "--repo"
            set NOESIS_REPO $argv[(math $i + 1)]
        case "-t" "--tag" 
            set NOESIS_TAG $argv[(math $i + 1)]
        case "-d" "--dir"
            set INSTALL_DIR $argv[(math $i + 1)]
        case "-h" "--help"
            echo "Usage: ./install_dependency.fish [options]"
            echo "Options:"
            echo "  -r, --repo URL   Specify Noesis repository URL"
            echo "  -t, --tag TAG    Specify Noesis version tag"
            echo "  -d, --dir DIR    Specify installation directory"
            echo "  -h, --help       Show this help message"
            exit 0
    end
end

echo "Installing Noesis Core dependency"
echo "================================"
echo "Repository: $NOESIS_REPO"
echo "Version:    $NOESIS_TAG"
echo "Directory:  $INSTALL_DIR"
echo

# Check if directory exists
if test -d "$INSTALL_DIR"
    echo "Directory already exists. Do you want to remove it? [y/N]"
    read -l confirm
    if test "$confirm" = "y" -o "$confirm" = "Y"
        rm -rf $INSTALL_DIR
    else
        echo "Aborting installation."
        exit 1
    end
end

# Clone the repository
echo "Cloning Noesis Core repository..."
git clone $NOESIS_REPO $INSTALL_DIR
if test $status -ne 0
    echo "Failed to clone repository."
    exit 1
end

# Checkout specific version if tag is provided
cd $INSTALL_DIR
if test "$NOESIS_TAG" != ""
    echo "Checking out version $NOESIS_TAG..."
    git checkout $NOESIS_TAG
    if test $status -ne 0
        echo "Failed to checkout tag $NOESIS_TAG."
        exit 1
    end
end

# Build Noesis Core
echo "Building Noesis Core..."
if test -e "./install.fish"
    ./install.fish
else
    make
end

if test $status -ne 0
    echo "Failed to build Noesis Core."
    exit 1
end

echo
echo "Noesis Core dependency installed successfully!"
echo "You can now build Noesis Extend with: ./install.fish"
