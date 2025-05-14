#!/bin/bash
# This script helps manage the fish-shell repository integration with noesis-hub

ensure_fish_repo() {
    external_path="$(pwd)/external"
    fish_repo_path="$external_path/fish-shell"
    
    if [ ! -d "$external_path" ]; then
        echo "Creating external directory..."
        mkdir -p "$external_path"
    fi
    
    if [ ! -d "$fish_repo_path" ]; then
        echo "Fish shell repository not found. Cloning it now..."
        pushd "$external_path" > /dev/null
        git clone https://github.com/fish-shell/fish-shell.git
        popd > /dev/null
    else
        echo "Fish shell repository already exists at $fish_repo_path"
        echo "To update to the latest version, run: cd $fish_repo_path && git pull"
    fi
    
    echo "Fish shell repository is ready at $fish_repo_path"
    return 0
}

build_fish() {
    fish_repo_path="$(pwd)/external/fish-shell"
    
    if [ ! -d "$fish_repo_path" ]; then
        echo "Fish shell repository not found. Run 'ensure_fish_repo' first."
        return 1
    fi
    
    echo "Building fish shell from the repository..."
    pushd "$fish_repo_path" > /dev/null
    
    # Create build directory
    mkdir -p build
    cd build
    
    # Configure with CMake
    cmake ..
    
    # Build
    make -j$(nproc 2>/dev/null || sysctl -n hw.ncpu)
    
    popd > /dev/null
    
    echo "Fish shell has been built successfully at $fish_repo_path/build"
    return 0
}

link_fish_to_noesis() {
    fish_build_path="$(pwd)/external/fish-shell/build"
    noesis_lib_path="$(pwd)/lib/fish"
    
    if [ ! -d "$fish_build_path" ]; then
        echo "Fish shell build not found. Run 'build_fish' first."
        return 1
    fi
    
    # Create the lib/fish directory if it doesn't exist
    mkdir -p "$noesis_lib_path"
    
    echo "Linking fish shell libraries to noesis-hub..."
    
    # Copy or link relevant libraries and binaries
    cp -r "$fish_build_path/fish" "$noesis_lib_path/"
    cp -r "$fish_build_path/share" "$noesis_lib_path/"
    
    echo "Fish shell has been linked to noesis-hub at $noesis_lib_path"
    return 0
}

# Handle command line arguments
if [ $# -ge 1 ]; then
    case "$1" in
        ensure)
            ensure_fish_repo
            ;;
        build)
            build_fish
            ;;
        link)
            link_fish_to_noesis
            ;;
        all)
            ensure_fish_repo
            build_fish
            link_fish_to_noesis
            ;;
        *)
            echo "Usage: link_fish.sh [ensure|build|link|all]"
            echo "  ensure  - Ensure fish-shell repository exists"
            echo "  build   - Build the fish-shell repository"
            echo "  link    - Link fish-shell to noesis-hub"
            echo "  all     - Run all steps"
            ;;
    esac
else
    # Default action if no arguments
    echo "Usage: link_fish.sh [ensure|build|link|all]"
    echo "  ensure  - Ensure fish-shell repository exists"
    echo "  build   - Build the fish-shell repository"
    echo "  link    - Link fish-shell to noesis-hub"
    echo "  all     - Run all steps"
fi
