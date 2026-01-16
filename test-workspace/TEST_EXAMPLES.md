# Test Examples and Common Operations

## 测试示例和常用操作 / Test Examples and Common Operations

This document provides practical examples of file system operations to test using this workspace.

## 基本操作示例 / Basic Operation Examples

### 1. 复制操作测试 / Copy Operation Tests

#### 复制单个文件 / Copy Single File
```bash
# Simple file copy
cp test-workspace/level1/simple.txt /tmp/test_copy.txt

# Copy file with spaces in name
cp "test-workspace/special chars/file with spaces.txt" /tmp/

# Copy Unicode filename
cp "test-workspace/special chars/文件中文名.txt" /tmp/

# Copy binary file
cp test-workspace/level1/binary_test.bin /tmp/
```

#### 递归复制目录 / Recursive Directory Copy
```bash
# Copy entire directory tree
cp -r test-workspace/level1 /tmp/test_level1

# Copy with special characters
cp -r "test-workspace/special chars" /tmp/

# Copy with symlinks (follow links)
cp -rL test-workspace/symlinks /tmp/symlinks_followed

# Copy with symlinks (preserve links)
cp -r test-workspace/symlinks /tmp/symlinks_preserved
```

#### 测试场景 / Test Scenarios
- ✓ Verify all files are copied
- ✓ Check file contents are identical (use `diff` or `md5sum`)
- ✓ Verify directory structure is preserved
- ✓ Check special characters are handled correctly
- ✓ Verify symbolic links behavior

### 2. 重命名操作测试 / Rename Operation Tests

#### 简单重命名 / Simple Rename
```bash
# Rename a file
cp test-workspace/similar_names/test_file.txt /tmp/test_file.txt
mv /tmp/test_file.txt /tmp/renamed_file.txt

# Rename with special characters
cp "test-workspace/special chars/file with spaces.txt" /tmp/
mv "/tmp/file with spaces.txt" "/tmp/file_with_underscores.txt"

# Rename Unicode file
cp "test-workspace/special chars/文件中文名.txt" /tmp/
mv "/tmp/文件中文名.txt" "/tmp/新名字.txt"
```

#### 重命名目录 / Rename Directory
```bash
# Copy and rename directory
cp -r test-workspace/branch_A /tmp/branch_A
mv /tmp/branch_A /tmp/branch_renamed

# Rename with special characters
cp -r "test-workspace/special chars/folder with spaces" /tmp/
mv "/tmp/folder with spaces" "/tmp/folder_renamed"
```

#### 测试场景 / Test Scenarios
- ✓ Verify file/directory is renamed correctly
- ✓ Check original file/directory no longer exists
- ✓ Verify contents are unchanged
- ✓ Test case-sensitive rename (lowercase to uppercase)
- ✓ Test conflict handling (rename to existing name)

### 3. 移动操作测试 / Move Operation Tests

#### 移动文件 / Move Files
```bash
# Move file to different directory
mkdir -p /tmp/test_dest
cp test-workspace/level1/simple.txt /tmp/simple.txt
mv /tmp/simple.txt /tmp/test_dest/

# Move multiple files
mkdir -p /tmp/test_multi
cp test-workspace/duplicates/*.txt /tmp/
mv /tmp/file*.txt /tmp/test_multi/

# Move across directories with special chars
mkdir -p /tmp/test_special
cp "test-workspace/special chars/文件中文名.txt" /tmp/
mv "/tmp/文件中文名.txt" /tmp/test_special/
```

#### 移动目录 / Move Directories
```bash
# Move directory tree
cp -r test-workspace/branch_A /tmp/
mkdir -p /tmp/new_location
mv /tmp/branch_A /tmp/new_location/

# Move nested directory
cp -r test-workspace/level1 /tmp/
mv /tmp/level1/level2 /tmp/
```

#### 测试场景 / Test Scenarios
- ✓ Verify files are moved (not copied)
- ✓ Check source location is empty
- ✓ Verify directory structure at destination
- ✓ Test moving to existing directory
- ✓ Test moving with name change

### 4. 删除操作测试 / Delete Operation Tests

#### 删除文件 / Delete Files
```bash
# Delete single file
cp test-workspace/level1/simple.txt /tmp/
rm /tmp/simple.txt

# Delete empty file
cp test-workspace/level1/empty_file.txt /tmp/
rm /tmp/empty_file.txt

# Delete file with special characters
cp "test-workspace/special chars/file with spaces.txt" /tmp/
rm "/tmp/file with spaces.txt"

# Delete multiple files
cp test-workspace/duplicates/*.txt /tmp/
rm /tmp/file1.txt /tmp/file2.txt /tmp/file3.txt
```

#### 递归删除目录 / Recursive Directory Delete
```bash
# Delete directory tree
cp -r test-workspace/branch_A /tmp/
rm -r /tmp/branch_A

# Delete with special characters
cp -r "test-workspace/special chars" /tmp/
rm -r "/tmp/special chars"

# Delete empty directories
cp -r test-workspace/empty_folders /tmp/
rm -r /tmp/empty_folders
```

#### 测试场景 / Test Scenarios
- ✓ Verify file/directory is deleted
- ✓ Check no remnants left behind
- ✓ Test deleting read-only files
- ✓ Test deleting symbolic links (link vs target)
- ✓ Verify error handling for non-existent files

## 高级测试场景 / Advanced Test Scenarios

### 5. 大小写敏感性测试 / Case Sensitivity Tests

```bash
# Test on case-sensitive filesystem
mkdir -p /tmp/case_test
cp test-workspace/case_test/*.txt /tmp/case_test/
ls -la /tmp/case_test/

# Try to rename with only case change
cd /tmp/case_test
mv readme.txt README_NEW.txt  # Should work on case-sensitive
# mv readme.txt README.txt    # May fail on case-insensitive

# Check if all three files exist
test -f readme.txt && echo "readme.txt exists"
test -f README.txt && echo "README.txt exists"
test -f ReadMe.txt && echo "ReadMe.txt exists"
```

### 6. 符号链接测试 / Symbolic Link Tests

```bash
# Create test directory
mkdir -p /tmp/link_test
cp -r test-workspace/symlinks /tmp/link_test/

# Test reading through symlink
cat /tmp/link_test/symlinks/link_to_original.txt

# Test if link is preserved or followed
ls -la /tmp/link_test/symlinks/

# Copy following links (dereference)
cp -rL test-workspace/symlinks /tmp/symlinks_followed
ls -la /tmp/symlinks_followed/

# Check broken links
ls -la /tmp/link_test/symlinks/link_to_parent.txt
cat /tmp/link_test/symlinks/link_to_parent.txt  # May fail if path is broken
```

### 7. 大文件操作测试 / Large File Operation Tests

```bash
# Copy large file
time cp test-workspace/level1/large_file.txt /tmp/

# Verify integrity
md5sum test-workspace/level1/large_file.txt
md5sum /tmp/large_file.txt

# Test partial read
head -n 100 /tmp/large_file.txt
tail -n 100 /tmp/large_file.txt

# Test streaming/buffering
cat /tmp/large_file.txt > /dev/null
```

### 8. 并发操作测试 / Concurrent Operation Tests

```bash
# Parallel copy operations
mkdir -p /tmp/concurrent_test
cp test-workspace/duplicates/file1.txt /tmp/concurrent_test/ &
cp test-workspace/duplicates/file2.txt /tmp/concurrent_test/ &
cp test-workspace/duplicates/file3.txt /tmp/concurrent_test/ &
wait

# Parallel directory operations
cp -r test-workspace/branch_A /tmp/concurrent_test/ &
cp -r test-workspace/branch_B /tmp/concurrent_test/ &
wait

# Verify results
ls -la /tmp/concurrent_test/
```

### 9. 权限和属性测试 / Permission and Attribute Tests

```bash
# Copy and check permissions
cp test-workspace/level1/script.sh /tmp/
ls -la /tmp/script.sh

# Test executable bit preservation
cp -p test-workspace/level1/script.sh /tmp/script_with_perms.sh
ls -la /tmp/script_with_perms.sh

# Test timestamp preservation
stat test-workspace/level1/simple.txt
cp -p test-workspace/level1/simple.txt /tmp/
stat /tmp/simple.txt
```

### 10. 边界条件测试 / Edge Case Tests

```bash
# Very long filename
cp test-workspace/long_names/b*.txt /tmp/
ls -la /tmp/

# Deep nesting
cp -r test-workspace/level1 /tmp/
ls -R /tmp/level1/level2/level3/level4/level5/

# Hidden files
cp test-workspace/.hidden_file /tmp/
cp -r test-workspace/.hidden_folder /tmp/
ls -la /tmp/ | grep hidden

# Trailing spaces in filename
cp "test-workspace/special chars/file_with_trailing_space .txt" /tmp/ 2>&1

# Empty files
cp test-workspace/level1/empty_file.txt /tmp/
test -s /tmp/empty_file.txt || echo "File is empty"
```

## 验证操作 / Verification Operations

### 内容完整性验证 / Content Integrity Verification

```bash
# Compare two files
diff test-workspace/duplicates/file1.txt test-workspace/duplicates/file2.txt

# Calculate checksums
md5sum test-workspace/level1/large_file.txt
sha256sum test-workspace/level1/binary_test.bin

# Compare directory trees
diff -r test-workspace/level1 /tmp/level1 || echo "Directories differ"

# Count files
find test-workspace/level1 -type f | wc -l
find /tmp/level1 -type f | wc -l
```

### 性能测试 / Performance Testing

```bash
# Time operations
time cp test-workspace/level1/large_file.txt /tmp/

# Measure throughput
ls -lh test-workspace/level1/large_file.txt
time cat test-workspace/level1/large_file.txt > /dev/null

# Test multiple operations
time for i in {1..100}; do
    cp test-workspace/level1/simple.txt /tmp/test_$i.txt
done
```

### 错误处理测试 / Error Handling Tests

```bash
# Test copying non-existent file
cp test-workspace/nonexistent.txt /tmp/ 2>&1 || echo "Error handled"

# Test copying to read-only location
mkdir -p /tmp/readonly_test
chmod -w /tmp/readonly_test
cp test-workspace/level1/simple.txt /tmp/readonly_test/ 2>&1 || echo "Permission denied"
chmod +w /tmp/readonly_test

# Test disk full scenario (requires setup)
# dd if=/dev/zero of=/tmp/test_fs bs=1M count=10
# mkfs.ext4 /tmp/test_fs
# etc...
```

## 自动化测试脚本 / Automated Test Script

### 完整测试套件 / Complete Test Suite

```bash
#!/bin/bash
# Comprehensive VFS test suite

echo "Starting VFS test suite..."

# Setup
TEST_DIR="/tmp/vfs_test_$$"
mkdir -p "$TEST_DIR"
cd test-workspace

PASS=0
FAIL=0

# Test 1: Basic copy
echo "Test 1: Basic file copy..."
if cp level1/simple.txt "$TEST_DIR/" && diff level1/simple.txt "$TEST_DIR/simple.txt" >/dev/null 2>&1; then
    echo "✓ PASS"
    ((PASS++))
else
    echo "✗ FAIL"
    ((FAIL++))
fi

# Test 2: Unicode copy
echo "Test 2: Unicode file copy..."
if cp "special chars/文件中文名.txt" "$TEST_DIR/" && test -f "$TEST_DIR/文件中文名.txt"; then
    echo "✓ PASS"
    ((PASS++))
else
    echo "✗ FAIL"
    ((FAIL++))
fi

# Test 3: Recursive copy
echo "Test 3: Recursive directory copy..."
if cp -r level1 "$TEST_DIR/" && diff -r level1 "$TEST_DIR/level1" >/dev/null 2>&1; then
    echo "✓ PASS"
    ((PASS++))
else
    echo "✗ FAIL"
    ((FAIL++))
fi

# Test 4: Rename
echo "Test 4: File rename..."
cp level1/simple.txt "$TEST_DIR/to_rename.txt"
if mv "$TEST_DIR/to_rename.txt" "$TEST_DIR/renamed.txt" && test -f "$TEST_DIR/renamed.txt" && ! test -f "$TEST_DIR/to_rename.txt"; then
    echo "✓ PASS"
    ((PASS++))
else
    echo "✗ FAIL"
    ((FAIL++))
fi

# Test 5: Delete
echo "Test 5: File delete..."
cp level1/simple.txt "$TEST_DIR/to_delete.txt"
if rm "$TEST_DIR/to_delete.txt" && ! test -f "$TEST_DIR/to_delete.txt"; then
    echo "✓ PASS"
    ((PASS++))
else
    echo "✗ FAIL"
    ((FAIL++))
fi

# Cleanup
rm -rf "$TEST_DIR"

# Summary
echo ""
echo "Test Summary:"
echo "Passed: $PASS"
echo "Failed: $FAIL"

if [ $FAIL -eq 0 ]; then
    echo "✓ All tests passed!"
    exit 0
else
    echo "✗ Some tests failed!"
    exit 1
fi
```

## 注意事项 / Important Notes

1. **路径长度**: 某些操作系统对路径长度有限制（Windows: 260字符）
   **Path Length**: Some operating systems have path length limits (Windows: 260 chars)

2. **文件名字符**: 不同文件系统对特殊字符的支持不同
   **Filename Characters**: Different filesystems have different special character support

3. **大小写敏感**: Windows和macOS默认不区分大小写
   **Case Sensitivity**: Windows and macOS are case-insensitive by default

4. **符号链接**: Windows需要管理员权限创建符号链接
   **Symbolic Links**: Windows requires admin privileges to create symlinks

5. **权限**: Unix系统需要注意文件权限和所有权
   **Permissions**: Unix systems need to consider file permissions and ownership
