# hello-world
Test Github App &amp; Git Action

## Test Workspace

This repository includes a comprehensive test workspace for verifying virtual file system operations.

### Features

The `test-workspace/` directory contains:
- 📁 Deep nested directory structures (5 levels)
- 🌍 Files and folders with international characters (中文, 日本語, кириллица)
- 🔤 Special character testing (spaces, dashes, dots, etc.)
- 🔗 Symbolic links for link handling tests
- 📝 Various file types (text, JSON, XML, binary, scripts)
- 🔄 Duplicate content files for copy testing
- 📛 Similar names for rename testing
- 🈚 Empty files and folders
- 🙈 Hidden files and folders
- 🔠 Case sensitivity testing files

### Usage

```bash
# Navigate to the test workspace
cd test-workspace

# View detailed documentation
cat README.md

# Run validation tests
bash validate_workspace.sh

# Regenerate the workspace if needed
bash create_structure.sh
```

### Purpose

This workspace is designed to test and verify:
- File system operation stability (copy, move, rename, delete)
- Edge case handling in virtual file systems
- Cross-platform compatibility
- Unicode and special character support
- Symbolic link handling
- Large file operations

See `test-workspace/README.md` for detailed documentation.
