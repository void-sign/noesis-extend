#!/bin/bash

# Script to cleanup and reorganize folder structure for Noesis Hub

echo "Cleaning up and reorganizing Noesis Hub directory structure..."

# Create required directories
mkdir -p scripts/fish scripts/bash src/core src/platforms src/tools tests docs/guides docs/changelogs

# Move scripts to the correct locations
# Fish scripts from fish_scripts to scripts/fish
if [ -d "fish_scripts" ]; then
    echo "Moving fish scripts to scripts/fish directory..."
    cp -f fish_scripts/*.fish scripts/fish/ 2>/dev/null
    
    # If we successfully copied some files, we can remove the old directory
    if [ $? -eq 0 ]; then
        echo "Removing old fish_scripts directory..."
        rm -rf fish_scripts
    fi
fi

# Move changelogs to proper location
if [ -d "changelogs" ] && [ ! -d "docs/changelogs" ]; then
    echo "Moving changelogs to docs/changelogs directory..."
    cp -rf changelogs/* docs/changelogs/ 2>/dev/null
    rm -rf changelogs
fi

# Move any stray .sh files to scripts/bash
for script in *.sh; do
    # Skip this file and scripts that are root entrypoints
    if [[ "$script" != "cleanup_structure.sh" && \
          "$script" != "run.sh" && \
          "$script" != "install.sh" && \
          "$script" != "install_dependency.sh" && \
          "$script" != "link_libraries.sh" && \
          "$script" != "launch_noesis_env.sh" && \
          "$script" != "add_external_lib.sh" ]]; then
        if [ -f "$script" ]; then
            echo "Moving $script to scripts/bash directory..."
            cp "$script" scripts/bash/
            rm "$script"
        fi
    fi
done

# Make all scripts executable
chmod +x scripts/fish/*.fish scripts/bash/*.sh *.sh *.fish 2>/dev/null

echo
echo "Clean up complete!"
echo "For any source files or other content, please manually move them to the appropriate directories:"
echo "  - Source code -> src/core, src/platforms, src/tools"
echo "  - Tests -> tests/"
echo "  - Documentation -> docs/guides/"
echo
echo "The new directory structure follows this pattern:"
echo "noesis-hub/"
echo "├── scripts/"
echo "│   ├── bash/       # Bash scripts"
echo "│   └── fish/       # Fish shell scripts"
echo "├── src/            # Source code"
echo "├── docs/           # Documentation"
echo "├── tests/          # Test files"
echo "└── [root files]    # Entry point scripts and docs"
echo
