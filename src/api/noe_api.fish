#!/usr/local/bin/fish

# NOE API Implementation in Fish
# This script provides API endpoints to process .noe files and communicate with noe-core

set -l API_PORT 3000
set -l UPLOAD_DIR "$PWD/temp/uploads"
set -l NOE_CORE_PATH "$PWD/../noe-core"  # Adjust this path as needed

# Create upload directory if it doesn't exist
mkdir -p $UPLOAD_DIR

function setup_api
    echo "Setting up NOE API server on port $API_PORT"
    
    # Check if socat is installed (needed for socket handling)
    if not command -v socat > /dev/null
        echo "Error: socat is required but not installed."
        echo "Please install it with: brew install socat"
        return 1
    end
end

function start_api_server
    echo "Starting NOE API server on port $API_PORT"
    
    # Start the socket listener in the background
    socat TCP-LISTEN:$API_PORT,fork,reuseaddr EXEC:$PWD/src/api/request_handler.fish &
    set -g API_PID $last_pid
    
    echo "API server started with PID $API_PID"
    echo "Ready to receive requests on port $API_PORT"
end

function stop_api_server
    if set -q API_PID
        echo "Stopping API server (PID $API_PID)"
        kill $API_PID
        set -e API_PID
    end
end

function process_noe_file
    set -l file_path $argv[1]
    
    if not test -f $file_path
        echo "Error: File not found: $file_path"
        return 1
    end
    
    # Check file extension
    if not string match -q "*.noe" $file_path
        echo "Error: Only .noe files are supported"
        return 1
    end
    
    echo "Processing .noe file: $file_path"
    
    # Execute the noe-core processor with the file
    if test -d $NOE_CORE_PATH
        echo "Sending file to noe-core for processing..."
        # Example of calling a script in noe-core to process the file
        # $NOE_CORE_PATH/bin/process_noe.fish $file_path
        
        # For now, just simulating processing
        cat $file_path | grep -v "^#" > $file_path.processed
        echo "File processed: $file_path.processed"
        
        # Return processed data as JSON
        echo "{"
        echo "  \"status\": \"success\","
        echo "  \"file\": \"$file_path\","
        echo "  \"processed_file\": \"$file_path.processed\","
        echo "  \"timestamp\": \"$(date)\""
        echo "}"
        
        return 0
    else
        echo "Error: noe-core repository not found at $NOE_CORE_PATH"
        return 1
    end
end

function check_noe_core_status
    if test -d $NOE_CORE_PATH
        echo "{"
        echo "  \"status\": \"connected\","
        echo "  \"path\": \"$NOE_CORE_PATH\""
        echo "}"
        return 0
    else
        echo "{"
        echo "  \"status\": \"disconnected\","
        echo "  \"message\": \"noe-core not found at path: $NOE_CORE_PATH\""
        echo "}"
        return 1
    end
end

function execute_noe_command
    set -l command $argv[1]
    
    echo "Executing command: $command"
    
    if test -d $NOE_CORE_PATH
        # In a real implementation, you would validate and sanitize the command
        # For security reasons, be very careful with command execution
        
        # Example of running a command in the noe-core directory
        set -l output (cd $NOE_CORE_PATH; eval $command)
        
        # Return output as JSON
        echo "{"
        echo "  \"status\": \"success\","
        echo "  \"command\": \"$command\","
        echo "  \"output\": \"$output\""
        echo "}"
        
        return 0
    else
        echo "{"
        echo "  \"status\": \"error\","
        echo "  \"message\": \"noe-core repository not found at $NOE_CORE_PATH\""
        echo "}"
        return 1
    end
end

# Main API entry point
function noe_api_main
    set -l command $argv[1]
    
    switch $command
        case "start"
            setup_api
            and start_api_server
            
        case "stop"
            stop_api_server
            
        case "status"
            check_noe_core_status
            
        case "process"
            if test (count $argv) -lt 2
                echo "Error: Missing file path"
                echo "Usage: noe_api.fish process <file_path>"
                return 1
            end
            process_noe_file $argv[2]
            
        case "exec"
            if test (count $argv) -lt 2
                echo "Error: Missing command"
                echo "Usage: noe_api.fish exec <command>"
                return 1
            end
            execute_noe_command $argv[2..-1]
            
        case "*"
            echo "NOE API - Fish Implementation"
            echo ""
            echo "Usage: noe_api.fish <command>"
            echo ""
            echo "Commands:"
            echo "  start          Start the API server"
            echo "  stop           Stop the API server"
            echo "  status         Check noe-core connection status"
            echo "  process <file> Process a .noe file"
            echo "  exec <cmd>     Execute a command in the noe-core repository"
    end
end

# Run the main function with all arguments
noe_api_main $argv
