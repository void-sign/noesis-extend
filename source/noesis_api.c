/*
 * Copyright (c) 2025 Napol Thanarangkaun (napol@noesis.run)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software under the following conditions as specified in the Noesis License.
 */

#include "../include/noesis_api.h"
#include <stdio.h>
#include <stdlib.h>

#ifdef __APPLE__
#include <dlfcn.h>
#elif defined(_WIN32)
#include <windows.h>
#else
#include <dlfcn.h>
#endif

// Platform-independent dynamic library handling
#ifdef _WIN32
typedef HMODULE lib_handle_t;
#define LOAD_LIBRARY(name) LoadLibraryA(name)
#define GET_SYMBOL(handle, name) GetProcAddress(handle, name)
#define CLOSE_LIBRARY(handle) FreeLibrary(handle)
#else
typedef void* lib_handle_t;
#define LOAD_LIBRARY(name) dlopen(name, RTLD_LAZY)
#define GET_SYMBOL(handle, name) dlsym(handle, name)
#define CLOSE_LIBRARY(handle) dlclose(handle)
#endif

// Static handle storage for cleanup and reuse
static lib_handle_t global_lib_handle = NULL;
static NoesisAPI* cached_api = NULL;

NoesisAPI* load_noesis_api(const char* lib_path) {
    // Return cached API if already loaded
    if (cached_api && global_lib_handle) {
        return cached_api;
    }
    
    if (!lib_path) {
        fprintf(stderr, "Error: No library path provided\n");
        return NULL;
    }
    
    // Close any previously opened handle
    if (global_lib_handle) {
        CLOSE_LIBRARY(global_lib_handle);
        global_lib_handle = NULL;
        cached_api = NULL;
    }
    
    // Load the dynamic library
    lib_handle_t handle = LOAD_LIBRARY(lib_path);
    if (!handle) {
#ifdef _WIN32
        fprintf(stderr, "Error loading Noesis Core: Error code %lu\n", GetLastError());
#else
        fprintf(stderr, "Error loading Noesis Core: %s\n", dlerror());
#endif
        return NULL;
    }
    
    // Get the API function
    typedef NoesisAPI* (*GetAPIFunc)(void);
    GetAPIFunc get_api = (GetAPIFunc)GET_SYMBOL(handle, "noesis_get_api");
    
    if (!get_api) {
#ifdef _WIN32
        fprintf(stderr, "Error finding API function: Error code %lu\n", GetLastError());
#else
        fprintf(stderr, "Error finding API function: %s\n", dlerror());
#endif
        CLOSE_LIBRARY(handle);
        return NULL;
    }
    
    // Call function to get API structure
    NoesisAPI* api = get_api();
    if (!api) {
        fprintf(stderr, "Failed to get API structure\n");
        CLOSE_LIBRARY(handle);
        return NULL;
    }
    
    // Store handle and API for cleanup and reuse
    global_lib_handle = handle;
    cached_api = api;
    
    return api;
}

void unload_noesis_api(NoesisAPI* api) {
    // Avoid unused parameter warning
    (void)api;
    
    // Close the library handle if it's open
    if (global_lib_handle) {
        CLOSE_LIBRARY(global_lib_handle);
        global_lib_handle = NULL;
        cached_api = NULL;
    }
}
