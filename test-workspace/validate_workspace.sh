#!/bin/bash
# Validation script for test workspace
# Note: Not using 'set -e' because we want to continue testing even if individual tests fail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "Test Workspace Validation Script"
echo "=========================================="
echo ""

PASS=0
FAIL=0
WARN=0

# Function to report test results
report_test() {
    local test_name=$1
    local result=$2
    local message=$3
    
    if [ "$result" = "PASS" ]; then
        echo -e "${GREEN}✓${NC} $test_name: $message"
        ((PASS++))
    elif [ "$result" = "FAIL" ]; then
        echo -e "${RED}✗${NC} $test_name: $message"
        ((FAIL++))
    else
        echo -e "${YELLOW}⚠${NC} $test_name: $message"
        ((WARN++))
    fi
}

# Test 1: Check deep nesting
echo "Testing deep directory nesting..."
if [ -d "level1/level2/level3/level4/level5" ]; then
    report_test "Deep Nesting" "PASS" "5-level nesting exists"
else
    report_test "Deep Nesting" "FAIL" "5-level nesting not found"
fi

# Test 2: Check special character folders
echo "Testing special character folders..."
if [ -d "special chars/folder with spaces" ] && [ -d "special chars/文件夹中文名" ]; then
    report_test "Special Char Folders" "PASS" "Special character folders exist"
else
    report_test "Special Char Folders" "FAIL" "Some special character folders missing"
fi

# Test 3: Check special character files
echo "Testing special character files..."
if [ -f "special chars/file with spaces.txt" ] && [ -f "special chars/文件中文名.txt" ]; then
    report_test "Special Char Files" "PASS" "Special character files exist"
else
    report_test "Special Char Files" "FAIL" "Some special character files missing"
fi

# Test 4: Check duplicate content files
echo "Testing duplicate content files..."
if [ -f "duplicates/file1.txt" ] && [ -f "duplicates/file2.txt" ] && [ -f "duplicates/file3.txt" ]; then
    CONTENT1=$(cat "duplicates/file1.txt")
    CONTENT2=$(cat "duplicates/file2.txt")
    CONTENT3=$(cat "duplicates/file3.txt")
    
    if [ "$CONTENT1" = "$CONTENT2" ] && [ "$CONTENT2" = "$CONTENT3" ]; then
        report_test "Duplicate Content" "PASS" "All three files have identical content"
    else
        report_test "Duplicate Content" "FAIL" "Duplicate files have different content"
    fi
else
    report_test "Duplicate Content" "FAIL" "Duplicate files not found"
fi

# Test 5: Check empty files
echo "Testing empty files..."
if [ -f "level1/empty_file.txt" ]; then
    if [ ! -s "level1/empty_file.txt" ]; then
        report_test "Empty Files" "PASS" "Empty file is truly empty"
    else
        report_test "Empty Files" "FAIL" "Empty file has content"
    fi
else
    report_test "Empty Files" "FAIL" "Empty file not found"
fi

# Test 6: Check hidden files
echo "Testing hidden files..."
if [ -f ".hidden_file" ] && [ -d ".hidden_folder" ]; then
    report_test "Hidden Files" "PASS" "Hidden files and folders exist"
else
    report_test "Hidden Files" "FAIL" "Hidden files or folders missing"
fi

# Test 7: Check symbolic links
echo "Testing symbolic links..."
if [ -L "symlinks/link_to_original.txt" ]; then
    report_test "Symbolic Links" "PASS" "Symbolic links exist"
else
    report_test "Symbolic Links" "WARN" "Symbolic links not found (may not be supported)"
fi

# Test 8: Check branch structure
echo "Testing branch structure..."
if [ -d "branch_A/sub_A1/sub_A1a" ] && [ -d "branch_B/sub_B2/sub_B2a" ]; then
    report_test "Branch Structure" "PASS" "Parallel branch structure exists"
else
    report_test "Branch Structure" "FAIL" "Branch structure incomplete"
fi

# Test 9: Check case sensitivity files
echo "Testing case sensitivity files..."
if [ -f "case_test/readme.txt" ] && [ -f "case_test/README.txt" ] && [ -f "case_test/ReadMe.txt" ]; then
    report_test "Case Sensitivity" "PASS" "All case variants exist"
elif [ -f "case_test/readme.txt" ] || [ -f "case_test/README.txt" ]; then
    report_test "Case Sensitivity" "WARN" "Only some case variants exist (case-insensitive filesystem)"
else
    report_test "Case Sensitivity" "FAIL" "Case sensitivity test files missing"
fi

# Test 10: Check binary file
echo "Testing binary file..."
if [ -f "level1/binary_test.bin" ]; then
    # Use test -s for portability (checks if file size > 0)
    if [ -s "level1/binary_test.bin" ]; then
        report_test "Binary File" "PASS" "Binary file exists and has content"
    else
        report_test "Binary File" "FAIL" "Binary file is empty"
    fi
else
    report_test "Binary File" "FAIL" "Binary file not found"
fi

# Test 11: Check large file
echo "Testing large file..."
if [ -f "level1/large_file.txt" ]; then
    LINE_COUNT=$(wc -l < "level1/large_file.txt")
    if [ "$LINE_COUNT" -eq 1000 ]; then
        report_test "Large File" "PASS" "Large file has exactly 1000 lines"
    else
        report_test "Large File" "WARN" "Large file has $LINE_COUNT lines (expected 1000)"
    fi
else
    report_test "Large File" "FAIL" "Large file not found"
fi

# Test 12: Check various file types
echo "Testing various file types..."
TYPES_FOUND=0
[ -f "level1/script.sh" ] && ((TYPES_FOUND++))
[ -f "level1/data.json" ] && ((TYPES_FOUND++))
[ -f "level1/data.xml" ] && ((TYPES_FOUND++))
[ -f "level1/config.ini" ] && ((TYPES_FOUND++))

if [ "$TYPES_FOUND" -eq 4 ]; then
    report_test "File Types" "PASS" "All file types present"
else
    report_test "File Types" "WARN" "Only $TYPES_FOUND/4 file types found"
fi

# Test 13: Count total files and directories
echo "Testing overall structure..."
FILE_COUNT=$(find . -type f | wc -l)
DIR_COUNT=$(find . -type d | wc -l)

if [ "$FILE_COUNT" -gt 30 ] && [ "$DIR_COUNT" -gt 30 ]; then
    report_test "Overall Structure" "PASS" "Files: $FILE_COUNT, Directories: $DIR_COUNT"
else
    report_test "Overall Structure" "WARN" "Files: $FILE_COUNT, Directories: $DIR_COUNT (may be incomplete)"
fi

# Summary
echo ""
echo "=========================================="
echo "Validation Summary"
echo "=========================================="
echo -e "${GREEN}Passed:${NC}  $PASS"
echo -e "${YELLOW}Warnings:${NC} $WARN"
echo -e "${RED}Failed:${NC}  $FAIL"
echo ""

if [ "$FAIL" -eq 0 ]; then
    echo -e "${GREEN}✓ Test workspace validation successful!${NC}"
    exit 0
else
    echo -e "${RED}✗ Test workspace validation failed!${NC}"
    exit 1
fi
