#!/bin/bash
# Create test workspace structure

# 1. Basic nested folders
mkdir -p "level1/level2/level3/level4/level5"

# 2. Folders with special characters
mkdir -p "special chars/folder with spaces"
mkdir -p "special chars/folder-with-dashes"
mkdir -p "special chars/folder_with_underscores"
mkdir -p "special chars/folder.with.dots"
mkdir -p "special chars/文件夹中文名"
mkdir -p "special chars/フォルダ日本語"
mkdir -p "special chars/папка-кириллица"

# 3. Multiple parallel branches
mkdir -p "branch_A/sub_A1/sub_A1a"
mkdir -p "branch_A/sub_A2/sub_A2a"
mkdir -p "branch_B/sub_B1/sub_B1a"
mkdir -p "branch_B/sub_B2/sub_B2a"

# 4. Hidden folders
mkdir -p ".hidden_folder/nested"

# 5. Folders with similar names (for rename testing)
mkdir -p "similar_names/folder_test"
mkdir -p "similar_names/folder_test_backup"
mkdir -p "similar_names/folder_test_copy"
mkdir -p "similar_names/test_folder"

# 6. Empty folders
mkdir -p "empty_folders/empty1"
mkdir -p "empty_folders/empty2"
mkdir -p "empty_folders/empty3"

# 7. Very long folder name
mkdir -p "long_names/$(printf 'a%.0s' {1..100})"

# Create various test files
# Basic text files
echo "Hello World" > "level1/simple.txt"
echo "Test content" > "level1/level2/file.txt"
echo "Deep nested file" > "level1/level2/level3/level4/level5/deep.txt"

# Files with special characters in names
echo "Space test" > "special chars/file with spaces.txt"
echo "Dash test" > "special chars/file-with-dashes.txt"
echo "Underscore test" > "special chars/file_with_underscores.txt"
echo "Dot test" > "special chars/file.with.multiple.dots.txt"
echo "Chinese content" > "special chars/文件中文名.txt"
echo "Japanese content" > "special chars/ファイル日本語.txt"
echo "Cyrillic content" > "special chars/файл-кириллица.txt"

# Unicode content
echo "Unicode test: 你好世界 🌍 こんにちは привет" > "special chars/unicode_content.txt"

# Files with similar names (rename testing)
echo "Original" > "similar_names/test_file.txt"
echo "Backup" > "similar_names/test_file_backup.txt"
echo "Copy" > "similar_names/test_file_copy.txt"
echo "Similar" > "similar_names/file_test.txt"

# Duplicate content files (copy testing)
mkdir -p "duplicates"
echo "Same content" > "duplicates/file1.txt"
echo "Same content" > "duplicates/file2.txt"
echo "Same content" > "duplicates/file3.txt"

# Empty files
touch "level1/empty_file.txt"
touch "empty_folders/empty_file_in_folder.txt"

# Hidden files
echo "Hidden content" > ".hidden_file"
echo "Hidden in folder" > ".hidden_folder/.hidden_nested"

# Files with different extensions
echo "#!/bin/bash\necho 'test'" > "level1/script.sh"
echo '{"key": "value"}' > "level1/data.json"
echo '<?xml version="1.0"?><root></root>' > "level1/data.xml"
echo 'key=value' > "level1/config.ini"

# Binary-like file (with null bytes and special characters)
printf '\x00\x01\x02\x03\xFF\xFE\xFD' > "level1/binary_test.bin"

# Large text file
for i in {1..1000}; do
    echo "Line $i: This is a test line with some content to make it longer"
done > "level1/large_file.txt"

# File with very long name
echo "Long name test" > "long_names/$(printf 'b%.0s' {1..100}).txt"

# Multiple files in branch structure
for branch in branch_A branch_B; do
    for sub in sub_*1 sub_*2; do
        full_path="$branch/$sub"
        if [ -d "$full_path" ]; then
            echo "Content in $full_path" > "$full_path/file.txt"
        fi
    done
done

# Files for testing case sensitivity
mkdir -p "case_test"
echo "lowercase" > "case_test/readme.txt"
echo "uppercase" > "case_test/README.txt"
echo "mixed" > "case_test/ReadMe.txt"

# Files with trailing spaces and dots (problematic on some systems)
# Note: Some filesystems may not support these
echo "Trailing space test" > "special chars/file_with_trailing_space .txt" 2>/dev/null || true

# Symlink test files (if supported)
mkdir -p "symlinks"
echo "Original file" > "symlinks/original.txt"
ln -s original.txt "symlinks/link_to_original.txt" 2>/dev/null || true
ln -s ../level1/simple.txt "symlinks/link_to_parent.txt" 2>/dev/null || true

echo "Test workspace structure created successfully!"
