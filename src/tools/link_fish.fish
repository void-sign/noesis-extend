#!/usr/bin/env fish

# This script helps manage the fish-shell repository integration with noesis-hub

function ensure_fish_repo
    set external_path (pwd)/external
    set fish_repo_path $external_path/fish-shell
    
    if not test -d $external_path
        echo "Creating external directory..."
        mkdir -p $external_path
    end
    
    if not test -d $fish_repo_path
        echo "Fish shell repository not found. Cloning it now..."
        pushd $external_path
        git clone https://github.com/fish-shell/fish-shell.git
        popd
    else
        echo "Fish shell repository already exists at $fish_repo_path"
        echo "To update to the latest version, run: cd $fish_repo_path && git pull"
    end
    
    echo "Fish shell repository is ready at $fish_repo_path"
    return 0
end

function build_fish
    set fish_repo_path (pwd)/external/fish-shell
    
    if not test -d $fish_repo_path
        echo "Fish shell repository not found. Run 'ensure_fish_repo' first."
        return 1
    end
    
    echo "Building fish shell from the repository..."
    pushd $fish_repo_path
    
    # Create build directory
    mkdir -p build
    cd build
    
    # Configure with CMake
    cmake ..
    
    # Build
    make -j(nproc)
    
    popd
    
    echo "Fish shell has been built successfully at $fish_repo_path/build"
    return 0
end

function link_fish_to_noesis
    set fish_build_path (pwd)/external/fish-shell/build
    set noesis_lib_path (pwd)/lib/fish
    
    if not test -d $fish_build_path
        echo "Fish shell build not found. Run 'build_fish' first."
        return 1
    end
    
    # Create the lib/fish directory if it doesn't exist
    mkdir -p $noesis_lib_path
    
    echo "Linking fish shell libraries to noesis-hub..."
    
    # Copy or link relevant libraries and binaries
    cp -r $fish_build_path/fish $noesis_lib_path/
    cp -r $fish_build_path/share $noesis_lib_path/
    
    echo "Fish shell has been linked to noesis-hub at $noesis_lib_path"
    return 0
end

# Handle command line arguments
if test (count $argv) -ge 1
    switch $argv[1]
        case ensure
            ensure_fish_repo
        case build
            build_fish
        case link
            link_fish_to_noesis
        case all
            ensure_fish_repo
            build_fish
            link_fish_to_noesis
        case '*'
            echo "Usage: link_fish.fish [ensure|build|link|all]"
            echo "  ensure  - Ensure fish-shell repository exists"
            echo "  build   - Build the fish-shell repository"
            echo "  link    - Link fish-shell to noesis-hub"
            echo "  all     - Run all steps"
    end
else
    # Default action if no arguments
    echo "Usage: link_fish.fish [ensure|build|link|all]"
    echo "  ensure  - Ensure fish-shell repository exists"
    echo "  build   - Build the fish-shell repository"
    echo "  link    - Link fish-shell to noesis-hub"
    echo "  all     - Run all steps"
end
