#!/usr/local/bin/fish

# NOE API Configuration

# API server settings
set -g API_PORT 3000
set -g API_HOST "localhost"

# noe-core integration settings
# The path to the noe-core repository
# This can be overridden by setting the NOE_CORE_PATH environment variable
set -g NOE_CORE_PATH (test -n "$NOE_CORE_PATH"; and echo $NOE_CORE_PATH; or echo "$PWD/../noe-core")

# Commands to execute in the noe-core repository
set -g NOE_COMMANDS_STATUS "status"
set -g NOE_COMMANDS_PROCESS "process"
set -g NOE_COMMANDS_EXECUTE "execute"

# File upload settings
# Maximum file size in bytes (default: 10MB)
set -g MAX_UPLOAD_SIZE (test -n "$MAX_UPLOAD_SIZE"; and echo $MAX_UPLOAD_SIZE; or echo 10485760)

# Allowed file types
set -g ALLOWED_FILE_TYPES ".noe"

# Logging settings
set -g LOG_LEVEL (test -n "$LOG_LEVEL"; and echo $LOG_LEVEL; or echo "info")
set -g LOG_FILE (test -n "$LOG_FILE"; and echo $LOG_FILE; or echo "$PWD/api.log")
