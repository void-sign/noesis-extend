# Migration Plan for Restructured Noesis Hub

This document outlines the step-by-step process to fully migrate from the old repository structure to the new standardized structure.

## Current Status

We've established a new directory structure with:

- `src/` directory for all source code, organized by functional area
- `scripts/` directory with separate `bash/` and `fish/` folders
- `docs/` directory with `changelogs/` and `guides/` 
- `include/` directory with proper namespace structure

## Migration Steps

### Step 1: Adopt the New Makefile

1. Review and test the new Makefile (`Makefile.new`)
2. Once verified, replace the old Makefile:
   ```fish
   mv Makefile.new Makefile
   ```

### Step 2: Update VS Code Configuration

1. Apply the new VS Code task configuration:
   ```fish
   mv .vscode/tasks.json.new .vscode/tasks.json
   mv .vscode/launch.json.new .vscode/launch.json
   ```

### Step 3: Update Script Files

1. Apply the updated script files:
   ```fish
   for f in scripts/fish/*.new
      set target (echo $f | sed 's/.new//')
      mv $f $target
   done
   ```

2. Make scripts executable:
   ```fish
   chmod +x scripts/fish/*.fish
   chmod +x scripts/bash/*.sh
   chmod +x run.sh run.fish
   ```

### Step 4: Remove Old Source Files

Once the new structure is verified working:
```fish
# Backup original source just in case
mkdir -p backup/source
cp -r source/* backup/source/

# Remove old source directory
rm -rf source
```

### Step 5: Update Documentation

1. Apply the updated README:
   ```fish
   cp docs/guides/README.md.new README.md
   rm docs/guides/README.md.new
   ```

### Step 6: Clean Up Transition Files

After all tests pass:
```fish
find . -name "*.new" -delete
```

## Verification Steps

After migration, verify the system by:

1. Building the project:
   ```fish
   make clean
   make
   ```

2. Running the tests:
   ```fish
   make test
   ```

3. Running the application:
   ```fish
   ./run.fish
   ```

## Rollback Plan

If any issues arise, you can roll back to the original structure:
```fish
# Restore original files
cp -r backup/source/* source/
# Use original Makefile
git checkout -- Makefile
# Use original VS Code config
git checkout -- .vscode/tasks.json .vscode/launch.json
```
