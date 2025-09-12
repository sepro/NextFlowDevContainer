#!/bin/bash

# Create output directory if it doesn't exist
mkdir -p test_output

# Create files with random names
for i in $(seq 1 3); do
    # Generate random filename
    random_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
    filename="file_${random_name}.txt"

    # Create the file with some content
    echo "This is file $i with random name: $filename" > "$filename"
    echo "Created at: $(date)" >> "$filename"
    echo "Random content: $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1)" >> "$filename"

    echo "Created file: $filename"
done

echo "Successfully created 3 files"
