#!/usr/local/bin/fish

# Script to add external libraries to Noesis Hub
# This script helps integrate external libraries with the project

function add_external_lib
    if test (count $argv) -lt 1
        echo "Usage: add_external_lib [library_name] [git_url]"
        return 1
    end

    set lib_name $argv[1]
    set git_url $argv[2]
    set external_path (pwd)/external

    if not test -d $external_path
        echo "Creating external directory..."
        mkdir -p $external_path
    end

    if not test -d $external_path/$lib_name
        echo "Cloning $lib_name repository..."
        pushd $external_path
        git clone $git_url $lib_name
        popd
        echo "$lib_name repository cloned successfully"
    else
        echo "$lib_name repository already exists at $external_path/$lib_name"
        echo "To update to the latest version, run: cd $external_path/$lib_name && git pull"
    end
end

# Run the function with provided arguments
add_external_lib $argv
