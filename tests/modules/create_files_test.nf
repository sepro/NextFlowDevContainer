// Test version of CREATE_FILES without publishDir
process CREATE_FILES {
    input:
    val num_files
    val output_dir
    
    output:
    path "file_*.txt", emit: created_files
    
    script:
    """
    #!/bin/bash
    
    # Create output directory if it doesn't exist
    mkdir -p ${output_dir}
    
    # Create files with random names
    for i in \$(seq 1 ${num_files}); do
        # Generate random filename
        random_name=\$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
        filename="file_\${random_name}.txt"
        
        # Create the file with some content
        echo "This is file \$i with random name: \$filename" > "\$filename"
        echo "Created at: \$(date)" >> "\$filename"
        echo "Random content: \$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1)" >> "\$filename"
        
        echo "Created file: \$filename"
    done
    
    echo "Successfully created ${num_files} files"
    """
}