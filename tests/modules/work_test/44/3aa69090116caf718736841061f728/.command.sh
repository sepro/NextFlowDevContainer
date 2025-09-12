#!/bin/bash

echo "Starting to process file: test_file.txt" > processed_test_file.log
echo "Process started at: $(date)" >> processed_test_file.log

# Check if file exists
if [ -f "test_file.txt" ]; then
    echo "File exists, opening and closing..." >> processed_test_file.log

    # Open and close the file (simulate file processing)
    cat "test_file.txt" > /dev/null
    echo "File content read successfully" >> processed_test_file.log

    # Sleep for 10 seconds as requested
    echo "Sleeping for 10 seconds..." >> processed_test_file.log
    sleep 10

    echo "Processing completed at: $(date)" >> processed_test_file.log
    echo "File test_file.txt processed successfully" >> processed_test_file.log
else
    echo "ERROR: File test_file.txt does not exist!" >> processed_test_file.log
    exit 1
fi

echo "Process finished for: test_file.txt"
