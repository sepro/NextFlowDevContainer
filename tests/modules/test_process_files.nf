#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { PROCESS_FILES } from './process_files_test'

workflow {
    test_process_files()
}

workflow test_process_files {
    // Create a test file - use absolute path
    test_file = Channel.fromPath("/workspaces/NextFlow test/tests/data/test_file.txt")
    
    PROCESS_FILES(test_file)
    
    // Verify output log file is created
    PROCESS_FILES.out.log
        .view { "Created log: $it" }
        .map { file ->
            assert file.exists() : "Log file should exist: $file"
            assert file.text.contains("Processing completed") : "Log should contain completion message"
            "✅ PROCESS_FILES test passed: Log file created and contains expected content"
        }
        .view()
}