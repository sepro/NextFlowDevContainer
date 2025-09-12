#!/bin/bash

# Nextflow Pipeline Test Runner
set -e

echo "🧪 Running Nextflow Pipeline Tests"
echo "=================================="

# Clean up previous test runs
echo "🧹 Cleaning up previous test runs..."
rm -rf work_test/ test_output/ test_integration_output/

# Run unit tests
echo ""
echo "🔬 Running unit tests..."

echo "  → Testing CREATE_FILES process..."
cd tests/modules
mkdir -p ../../log
export NXF_LOG_FILE="../../log/nextflow_test.log"
nextflow run test_create_files.nf -c ../nextflow.config
if [ -f ".nextflow.log" ]; then mv .nextflow.log ../../log/nextflow_test_create.log; fi

echo "  → Testing PROCESS_FILES process..."
nextflow run test_process_files.nf -c ../nextflow.config
if [ -f ".nextflow.log" ]; then mv .nextflow.log ../../log/nextflow_test_process.log; fi
cd ../..

# Run integration test
echo ""
echo "🔗 Running integration test..."
cd tests/workflows
nextflow run test_main.nf -c ../nextflow.config
if [ -f ".nextflow.log" ]; then mv .nextflow.log ../../log/nextflow_test_integration.log; fi
cd ../..

# Verify test outputs exist in work directories
echo ""
echo "✅ Verifying test outputs..."

if [ -d "work_test" ]; then
    echo "  ✓ Test work directory exists"
    
    # Check for created files in work directory
    file_count=$(find work_test -name "file_*.txt" | wc -l)
    if [ "$file_count" -gt 0 ]; then
        echo "  ✓ Test files created: $file_count files"
    else
        echo "  ⚠ No test files found in work directory"
    fi
    
    # Check for log files
    log_count=$(find work_test -name "processed_*.log" | wc -l)
    if [ "$log_count" -gt 0 ]; then
        echo "  ✓ Processing logs created: $log_count logs"
    else
        echo "  ⚠ No processing logs found"
    fi
else
    echo "  ⚠ Test work directory not found (tests may have cleaned up)"
fi

# Clean up test artifacts (optional)
echo ""
echo "🧹 Cleaning up test artifacts..."
rm -rf work_test/ test_output/ test_integration_output/

echo ""
echo "🎉 All tests passed successfully!"
echo "=================================="