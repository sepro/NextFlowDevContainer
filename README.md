# Nextflow Skeleton Pipeline

A simple Nextflow pipeline that creates files with random names and processes them in parallel.

## Usage

```bash
nextflow run main.nf                                    # Default: 5 files  
nextflow run main.nf --num_files 10 --output_dir ./tmp  # Custom parameters
```

When running this as a devcontainer use the following lines in `.devcontainer/devcontainer.json`

```json

  "runArgs": [
    "--privileged"
  ],
  "capAdd": [
    "SYS_ADMIN"
  ],
  "securityOpt": [
    "apparmor:unconfined"
  ]

```

## Parameters

- `--num_files`: Number of files to create (default: 5)
- `--output_dir`: Output directory for files (default: 'output')
- `--help`: Show help message

## What it does

1. Creates specified number of files with random names
2. Processes each file in parallel (reads file and sleeps 10 seconds)
3. Generates processing logs for each file

## Testing

Run all tests:

```bash
./run_tests.sh
```

Run individual test modules:

```bash
# Test file creation process
nextflow run tests/modules/test_create_files.nf -c tests/nextflow.config

# Test file processing process  
nextflow run tests/modules/test_process_files.nf -c tests/nextflow.config

# Test full pipeline integration
nextflow run tests/workflows/test_main.nf -c tests/nextflow.config
```

## Logs and Reports

All pipeline logs and reports are automatically stored in the `./log/` directory:
- `nextflow.log` - Main pipeline execution log (automatically moved after completion)
- `timeline.html` - Execution timeline visualization
- `report.html` - Detailed execution report  
- `trace.txt` - Process execution trace
- `dag.html` - Pipeline DAG visualization

No wrapper scripts needed - log redirection is built into the pipeline configuration.

## Prerequisites

- Nextflow (version >= 21.10.0)
- Java 8 or later
