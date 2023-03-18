process RUN_CHICAGO {
    tag "$meta.id"
    container "ghcr.io/dhslab/docker-chicago"
    
    publishDir "$params.outdir/${meta.id}/", mode:'copy', pattern: 'chicago_calls/*'
    cpus 8
    memory '32 GB'

    input:
    tuple val(meta), path(chinput)
    path (design_directory)
    path (features_file)
   
    output:
    tuple val(meta), path('chicago_calls/*'), emit: chicago_calls
    
    script:
    def features_file_cmd = (params.features_file) ?"--en-feat-list ${features_file}" : "" 
        """
        runChicago.R \\
        --design-dir ${design_directory} \\
        --cutoff ${params.score_cutoff} \\
        --export-format ${params.export_format} \\
        ${features_file_cmd} \\
        ${chinput} \\
        ${meta.id}

        make_bedpe.sh ${meta.id}/data/${meta.id}.ibed ${meta.id}/data/${meta.id}.bedpe
        
        mv ${meta.id} chicago_calls
        """
}