# Noesis Extend Makefile

# Compiler
CC = gcc

# Directories
QUANTUM_DIR = source/quantum
FIELD_DIR = source/quantum/field
TOOLS_DIR = source/tools
TEST_DIR = tests
OBJ_DIR = object
LIB_DIR = lib
BIN_DIR = bin

# Check for Noesis Core path (use environment variable or default)
ifndef NOESIS_CORE_PATH
    ifdef NOESIS_HOME
        CORE_LIB_DIR = $(NOESIS_HOME)
    else
        CORE_LIB_DIR = ../noesis
    endif
else
    CORE_LIB_DIR = $(NOESIS_CORE_PATH)
endif

# Source Files
SRCS = $(wildcard $(QUANTUM_DIR)/*.c) \
       $(wildcard $(FIELD_DIR)/*.c) \
       $(wildcard $(TOOLS_DIR)/*.c)

# Test Files
TEST_SRCS = $(wildcard $(TEST_DIR)/*.c)

# Object Files
OBJS = $(patsubst $(QUANTUM_DIR)/%.c, $(OBJ_DIR)/quantum/%.o, $(filter $(QUANTUM_DIR)/%, $(SRCS))) \
       $(patsubst $(FIELD_DIR)/%.c, $(OBJ_DIR)/quantum/field/%.o, $(filter $(FIELD_DIR)/%, $(SRCS))) \
       $(patsubst $(TOOLS_DIR)/%.c, $(OBJ_DIR)/tools/%.o, $(filter $(TOOLS_DIR)/%, $(SRCS)))

# Test Object Files
TEST_OBJS = $(patsubst $(TEST_DIR)/%.c, $(OBJ_DIR)/tests/%.o, $(TEST_SRCS))

# Executables
TARGET = $(BIN_DIR)/noesis_extend
TEST_TARGET = $(BIN_DIR)/noesis_extend_tests

# Flags
CFLAGS = -Wall -Wextra -std=c99
LDFLAGS = -L$(LIB_DIR) -lnoesis_core -Wl,-rpath,$(LIB_DIR)

# Add include directory to the compiler's include path
CFLAGS += -Iinclude -I$(CORE_LIB_DIR)/include

# Default target
all: setup $(TARGET)

# Setup directories
setup:
	@mkdir -p $(BIN_DIR) $(LIB_DIR) $(OBJ_DIR)/quantum/field $(OBJ_DIR)/tools $(OBJ_DIR)/tests

# Link main target
$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CC) $(OBJS) $(LDFLAGS) -o $(TARGET)

# Rule to create object files in the object directory
$(OBJ_DIR)/quantum/%.o: $(QUANTUM_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/quantum/field/%.o: $(FIELD_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/tools/%.o: $(TOOLS_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Build and run tests
test: $(TEST_TARGET)
	./$(TEST_TARGET)

$(TEST_TARGET): $(TEST_OBJS) $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CC) $(TEST_OBJS) $(OBJS) $(LDFLAGS) -o $(TEST_TARGET)

$(OBJ_DIR)/tests/%.o: $(TEST_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Clean build artifacts
clean:
	rm -rf $(OBJ_DIR)/*
	rm -f $(BIN_DIR)/noesis_extend $(BIN_DIR)/noesis_extend_tests

# Install target
install: all
	@echo "Noesis-Extend has been built and installed to the bin directory"
	@echo "You can run it with: ./run.fish"

.PHONY: all setup test clean install
