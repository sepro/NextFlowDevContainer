#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { CREATE_FILES } from '../modules/create_files_test'
include { PROCESS_FILES } from '../modules/process_files_test'

workflow {
    test_main_workflow()
}

workflow test_main_workflow {
    // Test parameters
    params.num_files = 3
    params.output_dir = 'test_integration_output'
    
    // Create output directory channel
    output_dir_ch = Channel.of(params.output_dir)
    
    // Step 1: Create files
    CREATE_FILES(params.num_files, output_dir_ch)
    
    // Step 2: Process files
    PROCESS_FILES(CREATE_FILES.out.created_files.flatten())
    
    // Verify the pipeline works end-to-end
    file_count = CREATE_FILES.out.created_files.flatten().count()
    log_count = PROCESS_FILES.out.log.count()
    
    file_count.combine(log_count)
        .view { file_c, log_c ->
            assert file_c == params.num_files : "Expected ${params.num_files} files, got $file_c"
            assert log_c == params.num_files : "Expected ${params.num_files} logs, got $log_c"
            "✅ Integration test passed: $file_c files created and $log_c logs generated"
        }
}

workflow.onComplete {
    println "Integration test completed!"
    println "Status: ${workflow.success ? 'PASSED' : 'FAILED'}"
}