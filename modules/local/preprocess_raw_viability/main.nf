process PREPROCESS_RAW_VIABILITY {
    //tag "$samplesheet"
    label 'process_low'
    publishDir "${path_data}", mode: 'copy'


    //conda "conda-forge::python=3.8.3"
    //container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
    //    'https://depot.galaxyproject.org/singularity/python:3.8.3' :
    //    'biocontainers/python:3.8.3' }"

    input:
    val dataset_name
    val path_data

    output:
    path "${dataset_name}/config.toml", emit: path_to_toml
    path "${dataset_name}/curvecurator_input.tsv", emit: curvecurator_input

    script:
    """
    preprocess_raw_viability.py --path_data ${path_data} --dataset_name ${dataset_name} --cores ${task.cpus}
    """
}