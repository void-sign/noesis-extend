/*
 * Copyright (c) 2025 Napol Thanarangkaun (napol@noesis.run)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software under the following conditions as specified in the Noesis License.
 */

#include "../include/quantum/quantum.h"
#include "../include/quantum/export.h"
#include "../include/quantum/backend.h"
#include "../include/noesis_api.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define VERSION "1.0.0"
#define MAX_BUFFER 4096

void print_banner() {
    printf("Noesis-Extend v%s\n", VERSION);
    printf("================================\n");
    
    #ifdef STANDALONE_MODE
    printf("Running in standalone mode (Noesis Core functionality disabled)\n\n");
    #else
    printf("Integration with Noesis Core enabled\n\n");
    #endif
}

void print_help() {
    printf("Available commands:\n");
    printf("  help       - Show this help message\n");
    printf("  version    - Show version information\n");
    printf("  quantum    - Enter quantum circuit mode\n");
    printf("  run        - Run the current quantum circuit\n");
    printf("  export     - Export the current circuit to QASM\n");
    printf("  exit       - Exit the program\n");
    printf("\n");
}

int main(int argc, char *argv[]) {
    print_banner();
    
    // Initialize quantum subsystem
    q_init();
    
    // Process command-line arguments
    if (argc > 1) {
        // Handle command-line mode
        if (strcmp(argv[1], "run") == 0) {
            printf("Running quantum circuit in batch mode...\n");
            // Additional implementation here
            return 0;
        }
    }
    
    // Interactive mode
    char input[256];
    char output[MAX_BUFFER];
    
    printf("Enter 'help' for available commands.\n\n");
    
    while (1) {
        printf("> ");
        if (fgets(input, sizeof(input), stdin) == NULL) break;
        
        // Remove newline
        size_t len = strlen(input);
        if (len > 0 && input[len-1] == '\n')
            input[len-1] = '\0';
        
        // Process commands
        if (strcmp(input, "exit") == 0 || strcmp(input, "quit") == 0) {
            break;
        } else if (strcmp(input, "help") == 0) {
            print_help();
        } else if (strcmp(input, "version") == 0) {
            printf("Noesis-Extend v%s\n", VERSION);
        } else if (strcmp(input, "quantum") == 0) {
            printf("Entering quantum circuit mode...\n");
            // Additional implementation here
        } else if (strcmp(input, "run") == 0) {
            printf("Running quantum circuit...\n");
            backend_run_stub(q_get_circuit());
        } else if (strcmp(input, "export") == 0) {
            char buffer[MAX_BUFFER];
            export_qasm(buffer, MAX_BUFFER, q_get_circuit());
            printf("Circuit QASM:\n%s\n", buffer);
        } else {
            // Try to process with Noesis Core if available
            q_process_with_noesis(input, output, MAX_BUFFER);
            printf("%s\n", output);
        }
    }
    
    printf("Exiting Noesis-Extend\n");
    return 0;
}
