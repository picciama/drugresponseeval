process FIT_CURVES {
    //tag "$samplesheet"
    label 'high_cpu_low_mem'
    publishDir "${path_data}", mode: 'copy'


    //conda "conda-forge::python=3.8.3"
    //container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
    //    'https://depot.galaxyproject.org/singularity/python:3.8.3' :
    //    'biocontainers/python:3.8.3' }"

    input:
    val dataset_name
    path path_data

    output:
    path './', emit: path_to_curvecurator_out

    script:
    """
    CurveCurator ${path_data}/${dataset_name}/config.toml --mad
    """
}
