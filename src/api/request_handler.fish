#!/usr/local/bin/fish

# NOE API Request Handler
# This script handles incoming HTTP requests and routes them to appropriate functions

set -l UPLOAD_DIR "$PWD/temp/uploads"
set -l NOE_CORE_PATH "$PWD/../noe-core"

function send_response
    set -l status $argv[1]
    set -l body $argv[2]
    
    echo "HTTP/1.1 $status"
    echo "Content-Type: application/json"
    echo "Content-Length: "(string length "$body")
    echo "Access-Control-Allow-Origin: *"
    echo ""
    echo "$body"
end

function parse_request
    # Read the HTTP request from stdin
    set -l request_line (read)
    set -l request_parts (string split " " $request_line)
    
    if test (count $request_parts) -lt 3
        send_response "400 Bad Request" '{"error":"Invalid HTTP request"}'
        return 1
    end
    
    set -l method $request_parts[1]
    set -l path $request_parts[2]
    
    # Read headers
    set -l headers
    while read -l line
        set line (string trim $line)
        if test -z "$line"
            break
        end
        set -a headers $line
    end
    
    # Get content length from headers
    set -l content_length 0
    for header in $headers
        if string match -q "Content-Length:*" $header
            set content_length (string replace "Content-Length:" "" $header | string trim)
        end
    end
    
    # Read body if content length > 0
    set -l body ""
    if test $content_length -gt 0
        set body (read -n $content_length)
    end
    
    echo "HTTP Request: $method $path" >&2
    handle_request $method $path "$body" $headers
end

function handle_request
    set -l method $argv[1]
    set -l path $argv[2]
    set -l body $argv[3]
    set -l headers $argv[4]
    
    # Check route and call appropriate function
    switch "$method $path"
        case "GET /api/noe/status"
            # Check noe-core status
            if test -d $NOE_CORE_PATH
                send_response "200 OK" '{"status":"connected","path":"'$NOE_CORE_PATH'"}'
            else
                send_response "200 OK" '{"status":"disconnected","message":"noe-core repository not found"}'
            end
            
        case "POST /api/noe/process"
            # Handle file upload for processing
            # This is a simplified implementation - in a real-world scenario,
            # you'd need to parse multipart/form-data which is complex
            
            # For now, we'll simulate processing using a file already in the uploads directory
            set -l timestamp (date +%s)
            set -l test_file "$UPLOAD_DIR/test-$timestamp.noe"
            
            # Create a test file
            echo "This is a test .noe file content" > $test_file
            
            # Process the file
            if process_noe_file $test_file
                send_response "200 OK" '{"message":"File processed successfully","file":"'$test_file'"}'
            else
                send_response "500 Internal Server Error" '{"error":"Failed to process file"}'
            end
            
        case "POST /api/noe/command"
            # Extract command from JSON body
            # This is a simplified implementation
            set -l command (echo $body | string match -r '"command":"([^"]+)"' | string replace -r '"command":"([^"]+)"' '$1')
            
            if test -z "$command"
                send_response "400 Bad Request" '{"error":"Command is required"}'
                return
            end
            
            # Execute the command
            if test -d $NOE_CORE_PATH
                set -l output (cd $NOE_CORE_PATH; eval $command 2>&1)
                send_response "200 OK" '{"status":"success","command":"'$command'","output":"'$output'"}'
            else
                send_response "500 Internal Server Error" '{"status":"error","message":"noe-core repository not found"}'
            end
            
        case "OPTIONS *"
            # Handle CORS preflight requests
            send_response "200 OK" '{}'
            
        case "*"
            # Unknown route
            send_response "404 Not Found" '{"error":"Route not found: '$path'"}'
    end
end

function process_noe_file
    set -l file_path $argv[1]
    
    if not test -f $file_path
        echo "Error: File not found: $file_path" >&2
        return 1
    end
    
    # Check file extension
    if not string match -q "*.noe" $file_path
        echo "Error: Only .noe files are supported" >&2
        return 1
    end
    
    echo "Processing .noe file: $file_path" >&2
    
    # Simulate processing
    cat $file_path | grep -v "^#" > $file_path.processed
    
    return 0
end

# Main entry point - start parsing request
parse_request
