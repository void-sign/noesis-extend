#!/bin/bash

# Central controller script for Noesis Hub
# This script serves as a menu-based entry point for all bash scripts

# Function to display menu
show_menu() {
    echo "===== NOESIS HUB CONTROL CENTER ====="
    echo "Available commands:"
    echo "1. run             - Run Noesis Hub"
    echo "2. install         - Install Noesis Hub"
    echo "3. link_libraries  - Link with Core Libraries"
    echo "4. install_dep     - Install Core Dependencies"
    echo "5. add_lib         - Add External Library"
    echo "6. launch_env      - Launch Noesis Environment"
    echo "7. cleanup_struct  - Clean up Structure"
    echo "8. cleanup_repo    - Clean up Repository"
    echo "h. help           - Show this menu"
    echo "q. quit           - Exit this menu"
    echo "=================================="
}

# Function to execute a script with arguments
run_script() {
    local script=$1
    shift
    ./scripts/bash/$script.sh "$@"
}

# Handle arguments if provided
if [ $# -gt 0 ]; then
    case "$1" in
        run)
            run_script "run" "${@:2}"
            ;;
        install)
            run_script "install" "${@:2}"
            ;;
        link_libraries)
            run_script "link_libraries" "${@:2}"
            ;;
        install_dep)
            run_script "install_dependency" "${@:2}"
            ;;
        add_lib)
            run_script "add_external_lib" "${@:2}"
            ;;
        launch_env)
            run_script "launch_noesis_env" "${@:2}"
            ;;
        cleanup_struct)
            run_script "cleanup_structure" "${@:2}"
            ;;
        cleanup_repo)
            run_script "cleanup_repo" "${@:2}"
            ;;
        help)
            show_menu
            ;;
        *)
            echo "Unknown command: $1"
            show_menu
            exit 1
            ;;
    esac
    exit 0
fi

# Interactive menu if no arguments provided
show_menu
while true; do
    echo -n "Enter your choice: "
    read choice
    
    case "$choice" in
        1)
            run_script "run"
            ;;
        2)
            run_script "install"
            ;;
        3)
            run_script "link_libraries"
            ;;
        4)
            run_script "install_dependency"
            ;;
        5)
            run_script "add_external_lib"
            ;;
        6)
            run_script "launch_noesis_env"
            ;;
        7)
            run_script "cleanup_structure"
            ;;
        8)
            run_script "cleanup_repo"
            ;;
        h|help)
            show_menu
            ;;
        q|quit)
            echo "Exiting Noesis Hub Control Center."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
    echo
done
