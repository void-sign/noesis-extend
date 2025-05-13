#!/bin/fish

# add_external_lib.fish - Add external libraries to Noesis Hub without forking
# This script helps developers add external libraries to the project

# Default settings
set -l REPO_URL ""
set -l REPO_TAG ""
set -l INSTALL_DIR ""
set -l LIB_NAME ""
set -l HEADER_DIR "include"
set -l LIB_DIR "lib"
set -l BUILD_COMMAND "make"
set -l SYMLINK_ONLY 0

# Parse command line arguments
for i in (seq 1 (count $argv))
    switch $argv[$i]
        case "-r" "--repo"
            set REPO_URL $argv[(math $i + 1)]
        case "-t" "--tag" 
            set REPO_TAG $argv[(math $i + 1)]
        case "-d" "--dir"
            set INSTALL_DIR $argv[(math $i + 1)]
        case "-n" "--name"
            set LIB_NAME $argv[(math $i + 1)]
        case "-h" "--header-dir"
            set HEADER_DIR $argv[(math $i + 1)]
        case "-l" "--lib-dir"
            set LIB_DIR $argv[(math $i + 1)]
        case "-b" "--build-command"
            set BUILD_COMMAND $argv[(math $i + 1)]
        case "-s" "--symlink-only"
            set SYMLINK_ONLY 1
        case "--help"
            echo "Usage: ./add_external_lib.fish [options]"
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
    end
end

# Validate inputs
if test $SYMLINK_ONLY -eq 0
    if test -z "$REPO_URL"
        echo "Error: Repository URL is required."
        echo "Use --help for usage information."
        exit 1
    end
    
    if test -z "$INSTALL_DIR"
        echo "Error: Installation directory is required."
        echo "Use --help for usage information."
        exit 1
    end
end

if test -z "$LIB_NAME"
    echo "Error: Library name is required."
    echo "Use --help for usage information."
    exit 1
end

echo "Adding external library: $LIB_NAME"
echo "=================================="

# Clone repository if needed
if test $SYMLINK_ONLY -eq 0
    echo "Repository: $REPO_URL"
    echo "Directory:  $INSTALL_DIR"
    
    # Check if directory exists
    if test -d "$INSTALL_DIR"
        echo "Directory already exists. Do you want to remove it? [y/N]"
        read -l confirm
        if test "$confirm" = "y" -o "$confirm" = "Y"
            rm -rf $INSTALL_DIR
        else
            echo "Using existing directory."
        end
    end
    
    # Clone if directory doesn't exist
    if not test -d "$INSTALL_DIR"
        echo "Cloning repository..."
        git clone $REPO_URL $INSTALL_DIR
        if test $status -ne 0
            echo "Failed to clone repository!"
            exit 1
        end
        
        # Checkout specific tag/branch if specified
        if test -n "$REPO_TAG"
            cd $INSTALL_DIR
            git checkout $REPO_TAG
            if test $status -ne 0
                echo "Failed to checkout $REPO_TAG!"
                exit 1
            end
            cd -
        end
    end
    
    # Build the library
    echo "Building library..."
    set -l current_dir (pwd)
    cd $INSTALL_DIR
    eval $BUILD_COMMAND
    if test $status -ne 0
        echo "Build failed!"
        cd $current_dir
        exit 1
    end
    cd $current_dir
end

# Create directories if they don't exist
mkdir -p lib
mkdir -p include/$LIB_NAME

# Determine library path
set -l lib_path ""
if test $SYMLINK_ONLY -eq 1
    # Use the full specified path
    set lib_path "$LIB_DIR"
else
    # Use the installation directory
    set lib_path "$INSTALL_DIR/$LIB_DIR"
end

# Determine header path
set -l header_path ""
if test $SYMLINK_ONLY -eq 1
    # Use the full specified path
    set header_path "$HEADER_DIR"
else
    # Use the installation directory
    set header_path "$INSTALL_DIR/$HEADER_DIR"
end

# Create symbolic links for libraries
echo "Creating symbolic links for libraries..."

# Determine which library extension to use based on platform
if test (uname) = "Darwin"
    set lib_extension "dylib"
else
    set lib_extension "so"
end

# Try different library naming patterns
for lib_file in "$lib_path/lib$LIB_NAME.$lib_extension" "$lib_path/lib$LIB_NAME.a"
    if test -f "$lib_file"
        ln -sf "$lib_file" "lib/"(basename "$lib_file")
        echo "Linked: $lib_file"
    end
end

# Create symbolic links for headers
echo "Creating symbolic links for headers..."
if test -d "$header_path"
    # Link individual header files to avoid conflicts
    for header in "$header_path"/*.h
        if test -f "$header"
            ln -sf "$header" "include/$LIB_NAME/"(basename "$header")
            echo "Linked header: $header"
        end
    end
else
    echo "Warning: Header directory not found at $header_path"
end

echo
echo "Library $LIB_NAME added successfully!"
echo "To use this library in your code:"
echo "  1. Include headers with: #include \"$LIB_NAME/header.h\""
echo "  2. Update your Makefile to link with -l$LIB_NAME"
echo
