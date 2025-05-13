#!/bin/bash

# Comprehensive cleanup script for Noesis Hub repository restructuring
# This script will reorganize all files into the new directory structure

echo "=== Noesis Hub Repository Cleanup ==="
echo "Reorganizing directory structure according to new standards..."

# Create all necessary directories
mkdir -p src/core src/platforms src/tools \
         include/noesis \
         scripts/bash scripts/fish \
         docs/changelogs docs/guides \
         tests examples \
         lib bin

# Copy changelogs from original location to docs/changelogs
if [ -d "changelogs" ]; then
    echo "Moving changelogs to docs/changelogs/"
    cp -r changelogs/* docs/changelogs/ 2>/dev/null
    rm -rf changelogs
fi

# Move existing header files to proper include directory
echo "Organizing include files..."
find . -maxdepth 1 -name "*.h" -exec mv {} include/noesis/ \;

# Move all fish scripts to scripts/fish
if [ -d "fish_scripts" ]; then
    echo "Moving fish scripts to scripts/fish/"
    cp -r fish_scripts/* scripts/fish/ 2>/dev/null
    rm -rf fish_scripts
fi

# Move source files to src directory
echo "Organizing source files..."
# Core source files
find source -name "*.c" -exec cp {} src/core/ \; 2>/dev/null
find . -maxdepth 1 -name "*.c" -exec cp {} src/core/ \; 2>/dev/null
# Tools
if [ -d "source/tools" ]; then
    cp source/tools/*.c src/tools/ 2>/dev/null
fi

# Create root script entry points that call into scripts directory
echo "Creating script entry points..."

# Handle Bash scripts
for script in run.sh install.sh install_dependency.sh link_libraries.sh launch_noesis_env.sh add_external_lib.sh; do
    if [ -f "$script" ]; then
        # Move implementation to scripts/bash
        echo "Moving $script implementation to scripts/bash/"
        cp "$script" "scripts/bash/$script"
        
        # Create entry point script
        cat > "$script" << EOF
#!/bin/bash

# Root $script for Noesis Hub
# This script serves as an entry point that uses the restructured scripts

./scripts/bash/$script "\$@"
EOF
        chmod +x "$script"
    fi
done

# Handle Fish scripts
for script in run.fish install.fish install_dependency.fish link_libraries.fish launch_noesis_env.fish add_external_lib.fish; do
    if [ -f "$script" ]; then
        # Move implementation to scripts/fish
        echo "Moving $script implementation to scripts/fish/"
        cp "$script" "scripts/fish/$script"
        
        # Create entry point script
        cat > "$script" << EOF
#!/bin/fish

# Root $script for Noesis Hub
# This script serves as an entry point that uses the restructured scripts

./scripts/fish/$script \$argv
EOF
        chmod +x "$script"
    fi
done

# Create .gitkeep files in empty directories to maintain structure
find src include lib bin tests examples docs scripts -type d -empty -exec touch {}/.gitkeep \;

# Copy docs to their new locations
echo "Updating documentation..."
if [ -f "docs/guides/README.md.new" ]; then
    cp docs/guides/README.md.new docs/guides/README.md
    rm docs/guides/README.md.new
fi

# Update file permissions
echo "Setting file permissions..."
chmod +x scripts/bash/*.sh scripts/fish/*.fish *.sh *.fish

echo
echo "=== Cleanup Complete ==="
echo 
echo "New directory structure:"
echo "- src/: Source code (core, platforms, tools)"
echo "- include/: Header files"
echo "- scripts/: Scripts organized by shell type"
echo "- docs/: Documentation"
echo "- lib/ and bin/: Binary outputs"
echo "- tests/: Test files"
echo
echo "Note: Some manual review may still be needed for specific files."
echo "Please check the repository and update any remaining paths or references."
