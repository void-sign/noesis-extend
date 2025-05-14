#!/usr/local/bin/fish

# Script for launching the Noesis environment
# This script sets up the environment and launches the Noesis Hub shell

function launch_noesis_env
    set fish_path "./external/fish-shell"
    set build_dir "$fish_path/build"
    
    if not test -d $build_dir
        echo "Fish build directory not found. Please run './run.fish install' first."
        return 1
    end
    
    echo "Launching Noesis environment..."
    echo "Setting up environment variables..."
    
    # Set environment variables
    set -x NOESIS_ROOT (pwd)
    set -x FISH_PATH $fish_path
    set -x FISH_BUILD_PATH $build_dir
    
    # Launch the custom fish shell
    echo "Starting Noesis Hub shell environment..."
    $build_dir/fish
end

# Run the function with provided arguments
launch_noesis_env $argv
