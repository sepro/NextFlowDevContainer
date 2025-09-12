process PROCESS_FILES {
    tag "$file_path"
    
    input:
    path file_path
    
    output:
    path "processed_${file_path.baseName}.log", emit: log
    
    script:
    """
    #!/bin/bash
    
    echo "Starting to process file: ${file_path}" > processed_${file_path.baseName}.log
    echo "Process started at: \$(date)" >> processed_${file_path.baseName}.log
    
    # Check if file exists
    if [ -f "${file_path}" ]; then
        echo "File exists, opening and closing..." >> processed_${file_path.baseName}.log
        
        # Open and close the file (simulate file processing)
        cat "${file_path}" > /dev/null
        echo "File content read successfully" >> processed_${file_path.baseName}.log
        
        # Sleep for 10 seconds as requested
        echo "Sleeping for 10 seconds..." >> processed_${file_path.baseName}.log
        sleep 10
        
        echo "Processing completed at: \$(date)" >> processed_${file_path.baseName}.log
        echo "File ${file_path} processed successfully" >> processed_${file_path.baseName}.log
    else
        echo "ERROR: File ${file_path} does not exist!" >> processed_${file_path.baseName}.log
        exit 1
    fi
    
    echo "Process finished for: ${file_path}"
    """
}