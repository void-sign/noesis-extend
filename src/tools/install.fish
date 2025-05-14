#!/usr/local/bin/fish

# Script for installing and building Noesis Hub
# This script handles the full installation process

function install_noesis
    echo "Starting Noesis Hub installation..."
    
    # First, make sure the fish-shell repo is available
    ./src/tools/link_fish.fish
    
    # Build fish-shell
    set fish_path "./external/fish-shell"
    set build_dir "$fish_path/build"
    
    if not test -d $build_dir
        echo "Creating build directory for fish-shell..."
        mkdir -p $build_dir
    end
    
    echo "Building fish-shell..."
    pushd $build_dir
    cmake -G Ninja ..
    ninja
    popd
    
    echo "Linking libraries..."
    ./src/tools/link_libraries.fish
    
    echo "Noesis Hub installation complete!"
    echo "You can now run './run.fish launch_env' to start the Noesis Hub environment"
end

# Run the function with provided arguments
install_noesis $argv
