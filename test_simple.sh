#!/bin/bash

# Simple test runner for Nextflow pipeline
set -e

echo "🧪 Simple Pipeline Test"
echo "======================"

# Clean up
echo "🧹 Cleaning up..."
rm -rf work/ test_output/

# Test the pipeline with minimal parameters
echo "🔬 Testing pipeline..."
nextflow run main.nf --num_files 3 --output_dir test_output

# Verify outputs
echo "✅ Verifying outputs..."

if [ -d "test_output" ]; then
    file_count=$(ls test_output/file_*.txt 2>/dev/null | wc -l)
    if [ "$file_count" -eq 3 ]; then
        echo "  ✓ Created 3 files as expected"
    else
        echo "  ✗ Expected 3 files, found $file_count"
        exit 1
    fi
else
    echo "  ✗ Output directory not found"
    exit 1
fi

# Check that pipeline completed successfully
echo "  ✓ Pipeline completed successfully"

# Clean up
rm -rf work/ test_output/

echo ""
echo "🎉 Test passed!"
echo "==============="