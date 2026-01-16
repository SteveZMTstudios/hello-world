# Test Workspace for Virtual File System Testing

## 概述 / Overview

这个测试工作区包含了各种文件和文件夹结构，用于测试虚拟文件系统的操作能力，特别是复制、重命名、移动等操作的正确性和稳定性。

This test workspace contains various files and folder structures designed to test virtual file system operations, particularly the correctness and stability of copy, rename, and move operations.

## 目录结构 / Directory Structure

### 1. 深层嵌套测试 / Deep Nesting Test
```
level1/level2/level3/level4/level5/
```
- **目的 / Purpose**: 测试深层次目录嵌套的处理能力
- **测试场景 / Test Scenarios**: 
  - 递归复制深层目录
  - 深层路径的重命名操作
  - 路径长度限制测试

### 2. 特殊字符测试 / Special Characters Test
```
special chars/
├── folder with spaces/
├── folder-with-dashes/
├── folder_with_underscores/
├── folder.with.dots/
├── 文件夹中文名/
├── フォルダ日本語/
├── папка-кириллица/
├── file with spaces.txt
├── file-with-dashes.txt
├── file.with.multiple.dots.txt
├── 文件中文名.txt
├── ファイル日本語.txt
├── файл-кириллица.txt
└── unicode_content.txt
```
- **目的 / Purpose**: 测试特殊字符和国际化字符的处理
- **测试场景 / Test Scenarios**:
  - 含空格的文件名处理
  - Unicode字符（中文、日文、西里尔文）支持
  - 特殊符号（点、破折号、下划线）处理
  - 尾随空格的文件名处理

### 3. 相似名称测试 / Similar Names Test
```
similar_names/
├── folder_test/
├── folder_test_backup/
├── folder_test_copy/
├── test_folder/
├── test_file.txt
├── test_file_backup.txt
├── test_file_copy.txt
└── file_test.txt
```
- **目的 / Purpose**: 测试重命名操作的精确性
- **测试场景 / Test Scenarios**:
  - 重命名时避免文件名冲突
  - 相似文件名的区分
  - 批量重命名操作

### 4. 重复内容测试 / Duplicate Content Test
```
duplicates/
├── file1.txt (相同内容 / Same content)
├── file2.txt (相同内容 / Same content)
└── file3.txt (相同内容 / Same content)
```
- **目的 / Purpose**: 测试复制操作的正确性
- **测试场景 / Test Scenarios**:
  - 重复数据删除检测
  - 复制操作的完整性验证
  - 内容比较功能

### 5. 分支结构测试 / Branch Structure Test
```
branch_A/
├── sub_A1/
│   └── sub_A1a/
└── sub_A2/
    └── sub_A2a/
branch_B/
├── sub_B1/
│   └── sub_B1a/
└── sub_B2/
    └── sub_B2a/
```
- **目的 / Purpose**: 测试并行目录结构的处理
- **测试场景 / Test Scenarios**:
  - 批量复制多个分支
  - 目录树的合并操作
  - 并行操作的性能测试

### 6. 空文件和空文件夹测试 / Empty Files and Folders Test
```
empty_folders/
├── empty1/
├── empty2/
├── empty3/
└── empty_file_in_folder.txt
level1/empty_file.txt
```
- **目的 / Purpose**: 测试空文件和空目录的处理
- **测试场景 / Test Scenarios**:
  - 空文件的复制和移动
  - 空目录的创建和删除
  - 空内容的检测

### 7. 隐藏文件测试 / Hidden Files Test
```
.hidden_folder/
├── nested/
└── .hidden_nested
.hidden_file
```
- **目的 / Purpose**: 测试隐藏文件和文件夹的处理
- **测试场景 / Test Scenarios**:
  - 隐藏文件的可见性控制
  - 隐藏文件的复制和移动
  - 系统文件的过滤

### 8. 符号链接测试 / Symbolic Links Test
```
symlinks/
├── original.txt
├── link_to_original.txt -> original.txt
└── link_to_parent.txt -> ../level1/simple.txt
```
- **目的 / Purpose**: 测试符号链接的处理
- **测试场景 / Test Scenarios**:
  - 符号链接的识别
  - 链接复制 vs 目标文件复制
  - 断开链接的处理
  - 相对路径和绝对路径链接

### 9. 大小写敏感测试 / Case Sensitivity Test
```
case_test/
├── readme.txt
├── README.txt
└── ReadMe.txt
```
- **目的 / Purpose**: 测试文件系统的大小写敏感性
- **测试场景 / Test Scenarios**:
  - 大小写不同的同名文件处理
  - 重命名时的大小写处理
  - 跨平台兼容性

### 10. 长文件名测试 / Long Filename Test
```
long_names/
├── aaaa...aaaa/ (100个a / 100 'a's)
└── bbbb...bbbb.txt (100个b / 100 'b's)
```
- **目的 / Purpose**: 测试长文件名的处理
- **测试场景 / Test Scenarios**:
  - 文件名长度限制
  - 路径长度限制
  - 截断处理

### 11. 多种文件类型测试 / Various File Types Test
```
level1/
├── simple.txt (纯文本 / Plain text)
├── script.sh (Shell脚本 / Shell script)
├── data.json (JSON数据 / JSON data)
├── data.xml (XML数据 / XML data)
├── config.ini (配置文件 / Config file)
├── binary_test.bin (二进制数据 / Binary data)
└── large_file.txt (大文件 1000行 / Large file 1000 lines)
```
- **目的 / Purpose**: 测试不同文件类型的处理
- **测试场景 / Test Scenarios**:
  - 文本文件处理
  - 二进制文件处理
  - 大文件传输和复制
  - 文件类型识别

## 测试建议 / Testing Recommendations

### 基本操作测试 / Basic Operations Tests

1. **复制测试 / Copy Tests**
   ```bash
   # 复制单个文件 / Copy single file
   cp test-workspace/level1/simple.txt /tmp/test_copy.txt
   
   # 递归复制目录 / Recursive directory copy
   cp -r test-workspace/level1 /tmp/test_level1
   
   # 复制特殊字符文件 / Copy special character files
   cp "test-workspace/special chars/file with spaces.txt" /tmp/
   ```

2. **重命名测试 / Rename Tests**
   ```bash
   # 重命名文件 / Rename file
   mv test-workspace/similar_names/test_file.txt test-workspace/similar_names/renamed_file.txt
   
   # 重命名包含特殊字符的文件 / Rename file with special chars
   mv "test-workspace/special chars/文件中文名.txt" "test-workspace/special chars/新文件名.txt"
   ```

3. **移动测试 / Move Tests**
   ```bash
   # 移动文件到不同目录 / Move file to different directory
   mv test-workspace/level1/simple.txt test-workspace/level1/level2/
   
   # 移动整个目录 / Move entire directory
   mv test-workspace/branch_A test-workspace/level1/
   ```

4. **删除测试 / Delete Tests**
   ```bash
   # 删除单个文件 / Delete single file
   rm test-workspace/duplicates/file1.txt
   
   # 递归删除目录 / Recursive directory deletion
   rm -r test-workspace/empty_folders
   ```

### 边界条件测试 / Edge Case Tests

1. **路径长度限制 / Path Length Limits**
   - 测试超长路径的创建和访问
   - Test creation and access of very long paths

2. **并发操作 / Concurrent Operations**
   - 同时对多个文件进行操作
   - Simultaneous operations on multiple files

3. **权限测试 / Permission Tests**
   - 只读文件的复制
   - Copying read-only files

4. **跨文件系统操作 / Cross-Filesystem Operations**
   - 不同文件系统之间的文件传输
   - File transfer between different filesystems

## 验证方法 / Verification Methods

### 1. 文件完整性验证 / File Integrity Verification
```bash
# 使用校验和验证 / Verify using checksum
md5sum test-workspace/level1/large_file.txt
sha256sum test-workspace/level1/binary_test.bin
```

### 2. 目录结构验证 / Directory Structure Verification
```bash
# 列出所有文件 / List all files
find test-workspace -type f | sort

# 列出所有目录 / List all directories
find test-workspace -type d | sort

# 统计文件和目录数量 / Count files and directories
find test-workspace -type f | wc -l
find test-workspace -type d | wc -l
```

### 3. 内容验证 / Content Verification
```bash
# 验证重复文件内容相同 / Verify duplicate files have same content
diff test-workspace/duplicates/file1.txt test-workspace/duplicates/file2.txt

# 验证文件不为空 / Verify file is not empty
test -s test-workspace/level1/simple.txt && echo "File has content"
```

### 4. 特殊字符处理验证 / Special Character Handling Verification
```bash
# 列出包含特殊字符的文件 / List files with special characters
ls -la "test-workspace/special chars/"

# 读取Unicode内容 / Read Unicode content
cat "test-workspace/special chars/unicode_content.txt"
```

## 已知限制 / Known Limitations

1. **符号链接 / Symbolic Links**: 某些文件系统可能不支持符号链接 / Some filesystems may not support symbolic links
2. **文件名长度 / Filename Length**: 不同系统有不同的文件名长度限制（通常255字节）/ Different systems have different filename length limits (typically 255 bytes)
3. **路径长度 / Path Length**: Windows系统有260字符的路径长度限制 / Windows has a 260 character path length limit
4. **大小写敏感 / Case Sensitivity**: Windows文件系统通常不区分大小写 / Windows filesystems are typically case-insensitive
5. **特殊字符 / Special Characters**: 某些字符在特定文件系统中可能被禁止 / Some characters may be forbidden in specific filesystems

## 使用场景 / Use Cases

此测试工作区适用于以下场景：
This test workspace is suitable for the following scenarios:

1. **虚拟文件系统开发 / Virtual Filesystem Development**
   - 验证文件系统接口实现
   - Verify filesystem interface implementation

2. **文件管理器测试 / File Manager Testing**
   - 测试文件浏览、复制、移动功能
   - Test file browsing, copying, and moving features

3. **备份软件测试 / Backup Software Testing**
   - 验证备份和恢复功能
   - Verify backup and restore functionality

4. **同步工具测试 / Sync Tool Testing**
   - 测试文件同步的准确性
   - Test file synchronization accuracy

5. **跨平台兼容性测试 / Cross-Platform Compatibility Testing**
   - 验证在不同操作系统上的行为
   - Verify behavior on different operating systems

## 维护 / Maintenance

要重新生成此测试工作区：
To regenerate this test workspace:

```bash
cd test-workspace
rm -rf level1 branch_A branch_B "special chars" similar_names duplicates empty_folders .hidden_folder .hidden_file symlinks case_test long_names
bash create_structure.sh
```

## 许可证 / License

此测试工作区是 hello-world 项目的一部分，用于测试目的。
This test workspace is part of the hello-world project for testing purposes.
