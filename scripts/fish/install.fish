#!/bin/fish

echo "Noesis Hub Installation Script"
echo "==============================="
echo 

# Check for Noesis Core shared library
set -l NOESIS_FOUND 0

# Check environment variable for Noesis library path
if set -q NOESIS_LIBRARY_PATH
    if test -f "$NOESIS_LIBRARY_PATH/libnoesis_core.so" -o -f "$NOESIS_LIBRARY_PATH/libnoesis_core.dylib"
        set -gx NOESIS_LIB "$NOESIS_LIBRARY_PATH"
        set NOESIS_FOUND 1
        echo "Using Noesis Core library at: $NOESIS_LIB"
    end
else if set -q NOESIS_CORE_PATH
    set -gx NOESIS_HOME $NOESIS_CORE_PATH
    if test -f "$NOESIS_HOME/lib/libnoesis_core.so" -o -f "$NOESIS_HOME/lib/libnoesis_core.dylib"
        set -gx NOESIS_LIB "$NOESIS_HOME/lib"
        set NOESIS_FOUND 1
        echo "Using Noesis Core library at: $NOESIS_LIB"
    end
end

# If not found, try common locations
if test $NOESIS_FOUND -eq 0
    for location in "/usr/local/lib" "/usr/lib" "../noesis/lib" "/opt/noesis/lib"
        if test -f "$location/libnoesis_core.so" -o -f "$location/libnoesis_core.dylib"
            set -gx NOESIS_LIB "$location"
            set NOESIS_FOUND 1
            echo "Found Noesis Core library at: $NOESIS_LIB"
            break
        end
    end
end

# If still not found, offer options
if test $NOESIS_FOUND -eq 0
    echo "Noesis Core library not found. You have these options:"
    echo "1. Download and install Noesis Core"
    echo "2. Specify the path to an existing installation"
    echo "3. Continue without Noesis Core (standalone mode)"
    
    read -P "Choose an option (1-3): " choice
    
    switch $choice
        case "1"
            echo "Installing Noesis Core..."
            ./scripts/install_dependency.fish
            if test -d "../noesis" -a -f "../noesis/lib/libnoesis_core.so" -o -f "../noesis/lib/libnoesis_core.dylib"
                set -gx NOESIS_LIB "../noesis/lib"
                set NOESIS_FOUND 1
                echo "✓ Noesis Core installed successfully"
            else
                echo "Failed to install Noesis Core. Continuing in standalone mode."
                set -gx BUILD_STANDALONE 1
            end
        case "2"
            read -P "Enter the path to the directory containing libnoesis_core.so or libnoesis_core.dylib: " custom_path
            if test -f "$custom_path/libnoesis_core.so" -o -f "$custom_path/libnoesis_core.dylib"
                set -gx NOESIS_LIB "$custom_path"
                set NOESIS_FOUND 1
                echo "Using Noesis Core library at: $NOESIS_LIB"
            else
                echo "Library not found at specified path. Continuing in standalone mode."
                set -gx BUILD_STANDALONE 1
            end
        case "3"
            echo "Continuing without Noesis Core in standalone mode."
            set -gx BUILD_STANDALONE 1
        case "*"
            echo "Invalid option. Continuing in standalone mode."
            set -gx BUILD_STANDALONE 1
    end
end

# Clean any previous builds
make clean

# Build Noesis Hub
echo "Building Noesis Hub..."
if set -q BUILD_STANDALONE
    echo "Building in standalone mode (Noesis Core integration disabled)"
    make standalone
else
    # Link with Noesis Core if found
    echo "Linking with Noesis Core..."
    ./link_libraries.fish
    if test $status -ne 0
        echo "WARNING: Failed to link with Noesis Core. Falling back to standalone mode."
        set -gx BUILD_STANDALONE 1
        make standalone
    else
        echo "✓ Successfully linked with Noesis Core"
        make
    end
end

if test $status -ne 0
    echo "ERROR: Build failed."
    exit 1
end
echo "✓ Noesis Hub built successfully"

# Run tests
echo "Running tests..."
make test
if test $status -ne 0
    echo "WARNING: Some tests may have failed. Please check the output above."
else
    echo "✓ All tests passed"
end

echo
echo "Installation complete!"
echo "======================"
echo "You can now run Noesis Hub with:"
echo "  ./run.fish"
echo
if set -q BUILD_STANDALONE
    echo "Note: Running in standalone mode. Integration with Noesis Core disabled."
else
    echo "Note: Integration with Noesis Core enabled via API interface."
end
echo
