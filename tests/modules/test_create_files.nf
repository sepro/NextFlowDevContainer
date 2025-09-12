#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { CREATE_FILES } from './create_files_test'

workflow {
    test_create_files()
}

workflow test_create_files {
    // Test with 3 files
    num_files = 3
    output_dir = "test_output"
    
    CREATE_FILES(num_files, output_dir)
    
    // Verify outputs - flatten to get individual files, then count
    CREATE_FILES.out.created_files
        .flatten()
        .view { "Created file: $it" }
        .count()
        .view { count -> 
            assert count == 3 : "Expected 3 files, got $count"
            "✅ CREATE_FILES test passed: $count files created"
        }
}