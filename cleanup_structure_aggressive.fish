#!/usr/bin/env fish

echo "=== Noesis Hub Repository Structure Cleanup (Aggressive Mode) ==="
echo "This script will clean up folders that don't align with the new structure."
echo "WARNING: This will REMOVE old directories after copying their contents."
echo

# Ask for confirmation
read -P "Are you sure you want to proceed with removing old directories? (y/N) " confirm
if test "$confirm" != "y" -a "$confirm" != "Y"
    echo "Operation cancelled."
    exit 1
end

# Create necessary directories if they don't exist
mkdir -p src/core src/platforms src/tools \
         include/noesis \
         scripts/bash scripts/fish \
         docs/changelogs docs/guides \
         tests

# Move source files from source/ to src/
if test -d "source"
    echo "Moving files from source/ to src/"
    
    # Move core files
    if test -f "source/main.c"; or test -f "source/noesis_api.c"
        mkdir -p src/core
        cp -f source/*.c src/core/ 2>/dev/null
    end
    
    # Move tools
    if test -d "source/tools"
        mkdir -p src/tools
        if count source/tools/* >/dev/null 2>&1
            cp -rf source/tools/* src/tools/
        end
    end
    
    echo "Removing source/ directory"
    rm -rf source
end

# Move fish scripts from fish_scripts/ to scripts/fish/
if test -d "fish_scripts"
    echo "Moving scripts from fish_scripts/ to scripts/fish/"
    cp -f fish_scripts/*.fish scripts/fish/ 2>/dev/null
    echo "Removing fish_scripts/ directory"
    rm -rf fish_scripts
end

# Move header files to include directory
if test -f "noesis_api.h"
    echo "Moving noesis_api.h to include/"
    cp -f noesis_api.h include/ 2>/dev/null
    echo "Removing original noesis_api.h"
    rm noesis_api.h
end

# Move changelogs
if test -d "changelogs"
    echo "Moving changelogs to docs/changelogs/"
    cp -rf changelogs/* docs/changelogs/ 2>/dev/null
    echo "Removing changelogs/ directory"
    rm -rf changelogs
end

# Remove object directory
if test -d "object"
    echo "Removing 'object' directory as it's not part of the new structure"
    rm -rf object
end

# Check for data directory
if test -d "data"
    echo "The 'data' directory is not mentioned in the new structure"
    read -P "Do you want to remove the data directory? (y/N) " remove_data
    if test "$remove_data" = "y" -o "$remove_data" = "Y"
        rm -rf data
        echo "Removed data/ directory"
    else
        echo "Keeping data/ directory"
    end
end

# Make all scripts executable
chmod +x scripts/fish/*.fish scripts/bash/*.sh *.sh *.fish 2>/dev/null

echo
echo "Clean up operations completed!"
echo
echo "The new directory structure follows this pattern:"
echo "noesis-hub/"
echo "├── include/          # Header files"
echo "├── scripts/"
echo "│   ├── bash/         # Bash scripts"
echo "│   └── fish/         # Fish shell scripts"
echo "├── src/              # Source code"
echo "│   ├── core/         # Core functionality"
echo "│   ├── platforms/    # Platform-specific code"
echo "│   └── tools/        # Tool utilities"
echo "├── docs/             # Documentation"
echo "│   ├── changelogs/   # Release notes"
echo "│   └── guides/       # User guides"
echo "├── tests/            # Test files"
echo "└── [root files]      # Entry point scripts and docs"
