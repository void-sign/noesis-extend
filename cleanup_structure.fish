#!/usr/bin/env fish

echo "=== Noesis Hub Repository Structure Cleanup ==="
echo "This script will clean up folders that don't align with the new structure."

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
    
    echo "You may want to manually review the source/ directory before removing it"
    echo "To remove it after checking: 'rm -rf source'"
end

# Move fish scripts from fish_scripts/ to scripts/fish/
if test -d "fish_scripts"
    echo "Moving scripts from fish_scripts/ to scripts/fish/"
    cp -f fish_scripts/*.fish scripts/fish/ 2>/dev/null
    echo "Fish scripts have been moved to scripts/fish/"
    echo "You may want to manually review the fish_scripts/ directory before removing it"
    echo "To remove it after checking: 'rm -rf fish_scripts'"
end

# Move header files to include directory
if test -f "noesis_api.h"
    echo "Moving noesis_api.h to include/"
    cp -f noesis_api.h include/ 2>/dev/null
    echo "You may want to manually remove the original after checking: 'rm noesis_api.h'"
end

# Move changelogs
if test -d "changelogs"
    echo "Moving changelogs to docs/changelogs/"
    cp -rf changelogs/* docs/changelogs/ 2>/dev/null
    echo "Changelogs have been moved to docs/changelogs/"
    echo "You may want to manually review the changelogs/ directory before removing it"
    echo "To remove it after checking: 'rm -rf changelogs'"
end

# Check for object directory
if test -d "object"
    echo "The 'object' directory is not part of the new structure"
    echo "You may want to check its contents before removing it"
    echo "To remove it after checking: 'rm -rf object'"
end

# Check for data directory
if test -d "data"
    echo "The 'data' directory is not mentioned in the new structure"
    echo "You may want to check its contents and decide whether to keep it"
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
echo
echo "Note: This script only copies files to their new locations."
echo "After verifying that everything works, you can manually remove the old directories."
