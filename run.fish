#!/usr/local/bin/fish

# Central controller script for Noesis Hub
# This script serves as a menu-based entry point for all fish scripts

# Function to display menu
function show_menu
    echo "===== NOESIS HUB CONTROL CENTER ====="
    echo "Available commands:"
    echo "1. run             - Run Noesis Hub"
    echo "2. install         - Install Noesis Hub"
    echo "3. link_libraries  - Link with Core Libraries"
    echo "4. install_dep     - Install Core Dependencies"
    echo "5. add_lib         - Add External Library"
    echo "6. launch_env      - Launch Noesis Environment" 
    echo "7. cleanup_struct  - Clean up Structure"
    echo "8. cleanup_aggr    - Clean up Structure (Aggressive)"
    echo "h. help           - Show this menu"
    echo "q. quit           - Exit this menu"
    echo "=================================="
end

# Function to execute a script with arguments
function run_script
    set script $argv[1]
    set -e argv[1]
    ./scripts/fish/$script.fish $argv
end

# Handle arguments if provided
if test (count $argv) -gt 0
    switch $argv[1]
        case run
            run_script "run" $argv[2..-1]
        case install
            run_script "install" $argv[2..-1]
        case link_libraries
            run_script "link_libraries" $argv[2..-1]
        case install_dep
            run_script "install_dependency" $argv[2..-1]
        case add_lib
            run_script "add_external_lib" $argv[2..-1]
        case launch_env
            run_script "launch_noesis_env" $argv[2..-1]
        case cleanup_struct
            run_script "cleanup_structure" $argv[2..-1]
        case cleanup_aggr
            run_script "cleanup_structure_aggressive" $argv[2..-1]
        case help
            show_menu
        case '*'
            echo "Unknown command: $argv[1]"
            show_menu
            exit 1
    end
    exit 0
end

# Interactive menu if no arguments provided
show_menu
while true
    echo -n "Enter your choice: "
    read choice
    
    switch $choice
        case 1
            run_script "run"
        case 2
            run_script "install"
        case 3
            run_script "link_libraries"
        case 4
            run_script "install_dependency"
        case 5
            run_script "add_external_lib"
        case 6
            run_script "launch_noesis_env"
        case 7
            run_script "cleanup_structure"
        case 8
            run_script "cleanup_structure_aggressive"
        case h help
            show_menu
        case q quit
            echo "Exiting Noesis Hub Control Center."
            exit 0
        case '*'
            echo "Invalid choice. Please try again."
    end
    echo
end
