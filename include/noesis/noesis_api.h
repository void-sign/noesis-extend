/*
 * Copyright (c) 2025 Napol Thanarangkaun (napol@noesis.run)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software under the following conditions as specified in the Noesis License.
 */

#ifndef NOESIS_API_H
#define NOESIS_API_H

#include <stddef.h>

// Version information
#define NOESIS_API_VERSION_MAJOR 1
#define NOESIS_API_VERSION_MINOR 0

// Core function pointer types
typedef void (*NoesisInitFunc)(void);
typedef int (*NoesisProcessFunc)(const char* input, char* output, int max_output);
typedef int (*NoesisStatusFunc)(int status_type);

// API Structure
typedef struct {
    // Version info
    int version_major;
    int version_minor;
    
    // Core functions
    NoesisInitFunc init;
    NoesisProcessFunc process;
    NoesisStatusFunc get_status;
    
    // Memory management
    void* (*allocate)(size_t size);
    void (*deallocate)(void* ptr);
    
    // Additional functions can be added as needed
} NoesisAPI;

// Function to load the API
NoesisAPI* load_noesis_api(const char* lib_path);

// Function to unload the API
void unload_noesis_api(NoesisAPI* api);

#endif // NOESIS_API_H
