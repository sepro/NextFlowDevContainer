#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { CREATE_FILES } from './modules/local/create_files'
include { PROCESS_FILES } from './modules/local/process_files'

workflow {
    // Default parameters
    params.num_files = params.num_files ?: 5
    params.output_dir = params.output_dir ?: 'output'
    
    // Create output directory channel
    output_dir_ch = Channel.of(params.output_dir)
    
    // Step 1: Create files with random names
    CREATE_FILES(params.num_files, output_dir_ch)
    
    // Step 2: Process each file in parallel
    PROCESS_FILES(CREATE_FILES.out.created_files.flatten())
}

workflow.onComplete {
    println "Pipeline completed at: ${new Date()}"
    println "Status: ${workflow.success ? 'SUCCESS' : 'FAILED'}"
    
    // Move log file to log directory
    def logDir = file('./log')
    if (!logDir.exists()) {
        logDir.mkdirs()
    }
    
    def logFile = file('.nextflow.log')
    if (logFile.exists()) {
        logFile.moveTo('./log/nextflow.log')
        println "Moved log file to ./log/nextflow.log"
    }
}