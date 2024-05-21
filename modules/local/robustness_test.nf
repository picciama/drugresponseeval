process ROBUSTNESS_TEST {
    tag "${model_name}_${robustness_iteration}"
    label 'process_single'

    //conda "conda-forge::python=3.8.3"
    //container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
    //    'https://depot.galaxyproject.org/singularity/python:3.8.3' :
    //    'biocontainers/python:3.8.3' }"
    input:
    tuple val(split_id), path(split_dataset), val(model_name), path(best_hpams), val(robustness_iteration)
    path(path_data)
    val(test_mode)
    val(randomization_type)
    val(response_transformation)

    output:
    path('test_dataset_*.csv'),     emit: test_dataset

    script:
    """
    train_and_predict_final.py \\
        --mode robustness \\
        --model_name $model_name \\
        --split_id $split_id \\
        --split_dataset_path $split_dataset \\
        --hyperparameters_path $best_hpams \\
        --response_transformation $response_transformation \\
        --test_mode $test_mode \\
        --path_data $path_data \\
        --robustness_trial $robustness_iteration
    """

}