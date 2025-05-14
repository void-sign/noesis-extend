#!/usr/local/bin/fish

# Script for installing dependencies for Noesis Hub
# This script installs all required packages and dependencies

function install_dependency
    echo "Installing dependencies for Noesis Hub..."
    
    # Check which package manager is available
    if type -q brew
        echo "Using Homebrew package manager..."
        brew update
        
        # Install required packages
        set packages cmake ninja gcc g++ pkg-config gettext pcre2 ncurses
        for package in $packages
            echo "Installing $package..."
            brew install $package
        end
    else if type -q apt-get
        echo "Using apt package manager..."
        sudo apt-get update
        sudo apt-get install -y build-essential cmake ninja-build libncurses5-dev libpcre2-dev gettext
    else if type -q dnf
        echo "Using dnf package manager..."
        sudo dnf install -y gcc gcc-c++ cmake ninja-build ncurses-devel pcre2-devel gettext-devel
    else if type -q pacman
        echo "Using pacman package manager..."
        sudo pacman -Syu --noconfirm gcc cmake ninja ncurses pcre2 gettext
    else
        echo "No supported package manager found. Please install the following packages manually:"
        echo "- cmake"
        echo "- ninja or make"
        echo "- gcc and g++"
        echo "- libncurses"
        echo "- libpcre2"
        echo "- gettext"
        return 1
    end
    
    echo "Core dependencies installation complete!"
    echo "You may now run './run.fish install' to build the project"
end

# Run the function with provided arguments
install_dependency $argv
