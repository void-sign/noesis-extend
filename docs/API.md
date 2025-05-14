# Noesis Hub API Documentation

This document explains how to use the Fish-based API to communicate with the noe-core repository via `.noe` files.

## Overview

Noesis Hub API provides a simple interface to interact with the noe-core repository. It allows you to:

1. Check the connection status with noe-core
2. Process .noe files
3. Execute commands in the noe-core repository

## API Usage

### Starting the API Server

```fish
./run.fish start_api
```

Or from the interactive menu, select option `9`.

This will start the API server on port 3000 (default).

### Stopping the API Server

```fish
./run.fish stop_api
```

Or from the interactive menu, select option `0`.

### Checking API Status

```fish
./run.fish api_status
```

Or from the interactive menu, select option `s`.

### Processing a .noe File

```fish
./run.fish process_noe /path/to/file.noe
```

### Executing a Command in noe-core

```fish
./run.fish exec_noe "command to execute"
```

## RESTful API Endpoints

When the API server is running, you can access the following endpoints:

### GET /api/noe/status

Check the connection status with noe-core.

Example response:
```json
{
  "status": "connected",
  "path": "/path/to/noe-core"
}
```

### POST /api/noe/process

Process a .noe file.

Example request:
```
POST /api/noe/process
Content-Type: multipart/form-data

[file content]
```

Example response:
```json
{
  "message": "File processed successfully",
  "file": "/path/to/uploaded/file.noe"
}
```

### POST /api/noe/command

Execute a command in the noe-core repository.

Example request:
```json
{
  "command": "git status"
}
```

Example response:
```json
{
  "status": "success",
  "command": "git status",
  "output": "On branch main\nNothing to commit, working tree clean"
}
```

## Configuration

The API configuration is stored in `/src/api/config.fish`. You can modify this file to change the API port, noe-core path, and other settings.

## Troubleshooting

- Make sure socat is installed (`brew install socat`)
- Check that the noe-core repository path is correctly set
- Ensure the API scripts have executable permissions
